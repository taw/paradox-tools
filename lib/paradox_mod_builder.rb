require "yaml"
require "pathname"
require "set"

require_relative "paradox_game"
require_relative "paradox_mod_file_serializer"

class Pathname
  def write(content)
    open("w"){|fh| fh.write(content)}
  end
end

class ParadoxModBuilder
  def initialize(game, target)
    @game = game
    @target = Pathname(target)
    @localization = {}
  end
  def compare_with_reference!(reference)
    diff_paradox = __dir__ + "/../bin/diff_paradox"
    system *%W[#{diff_paradox} --normalize #{reference} #{@target}]
  end
  def localization!(group, locs)
    @localization[group] ||= {}
    locs.each do |tag, name|
      @localization[group][tag] = name
    end
  end
  def build!
    ensure_target_clear!
    build_mod_files!
    save_localization!
  end
  def save_localization!
    return if @localization.empty?
    case @game.localization_type
    when :ck2
      save_localization_ck2!
    when :eu4
      save_localization_eu4!
    else
      raise "No idea how to save localization"
    end
  end
  def save_localization_ck2!
    @localization.each do |group, data|
      create_file!("localisation/#{group}.csv",
        data.map{|k,v| "#{k};#{v};;;;;;;;;;;;;x\n" }.join
      )
    end
  end
  def save_localization_eu4!
    # YAML is about as much a standard as CSV, use Paradox compatible output instead of yaml gem
    @localization.each do |group, data|
      create_file!("localisation/#{group}_l_english.yml",
        # [0xEF, 0xBB, 0xBF].pack("C*") + # UTF-8 BOM, WTF?
        "l_english:\n" +
        data.map{|k,v| " #{k}: \"#{v}\"\n"}.join
      )
    end
  end
  def ensure_target_clear!
    system "trash", @target.to_s if @target.exist?
    @target.mkpath
  end
  def build_mod_files!
    raise "SubclassResponsibility"
  end
  # This is so you can apply multiple patches to same file
  def resolve(name)
    if (@target + name).exist?
      @target + name
    else
      @game.resolve(name)
    end
  end
  # This is not game parse as it will return modded file if it already exists
  def parse(path)
    ParadoxModFile.new(path: resolve(path)).parse!
  end
  def create_file!(name, content)
    (@target + name).parent.mkpath
    (@target + name).write(content)
  end
  def patch_file!(name, force_create: false, reencode: false)
    orig_content = resolve(name).read
    if reencode
      encoding = "windows-1252"
      encoding = reencode if reencode != true
      content = orig_content.force_encoding(encoding).encode("UTF-8", undef: :replace)
    else
      content = orig_content.dup
    end
    new_content = yield(content)
    new_content = new_content.encode(encoding, undef: :replace) if reencode
    create_file!(name, new_content) if orig_content != new_content or force_create
  end
  def patch_defines_lua!(changes)
    patch_file!("common/defines.lua", reencode: true) do |content|
      changes.each do |variable, orig, updated|
        content.sub!(/^(\s+#{variable}\s*=\s*)(.*?)(\s*,|\s*$)/) do
          if $2 == orig.to_s
            "#{$1}#{updated}#{$3}"
          else
            raise "Tried to change `#{variable}' from `#{orig}' to `#{updated}', but is it `#{$2}' instead"
          end
        end or raise("Tried to change `#{variable}' from `#{orig}' to `#{updated}', can't find it in the file")
      end
      content
    end
  end
  def patch_mod_files!(pattern, &blk)
    matches = (@game.glob(pattern) | @target.glob(pattern))
    raise "No matches found for `#{pattern}'" if matches.size == 0
    matches.each do |path|
      patch_mod_file!(path, &blk)
    end
  end
  def patch_mod_file!(path)
    patch_file!(path, reencode: true) do |content|
      orig_node = ParadoxModFile.new(string: content).parse!
      node = Marshal.load(Marshal.dump(orig_node)) # deep clone
      yield(node)
      if node == orig_node
        content
      else
        ParadoxModFileSerializer.serialize(node, orig_node)
      end
    end
  end
  def create_mod_file!(path, node)
    create_file! path, ParadoxModFileSerializer.serialize(node).encode("windows-1252")
  end
end

