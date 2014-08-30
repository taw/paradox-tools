require "yaml"
require "pathname"
require "set"

require_relative "paradox_game"

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
  def compare_file_with_reference!(rpath, tpath)
    if rpath.extname == ".txt" or rpath.extname == ".yml"
      diff_paradox = __dir__ + "/../bin/diff_paradox"
      system *%W[#{diff_paradox} #{rpath} #{tpath}]
    else
      system *%W[diff -wu #{rpath} #{tpath}]
    end
  end
  def compare_with_reference!(reference)
    reference = Pathname(reference)
    files_in_reference = Set[*reference.find.select(&:file?).map{|f| f.relative_path_from(reference)}]
    files_in_target    = Set[*@target.find.select(&:file?).map{|f| f.relative_path_from(@target)}]
    (files_in_reference & files_in_target).each do |path|
      compare_file_with_reference!(reference + path, @target + path)
    end
    (files_in_reference - files_in_target).each do |path|
      puts "Only in #{reference}: #{path}"
    end
    (files_in_target - files_in_reference).each do |path|
      puts "Only in #{@target}: #{path}"
    end
  end
  def add_localization!(group, tag, name)
    @localization[group] ||= {}
    @localization[group][tag] = name
  end
  def save_localization!
    # YAML is about as much a standard as CSV, use Paradox compatible output instead of yaml gem
    @localization.each do |group, data|
      create_file!("localisation/#{group}_l_english.yml",
        [0xEF, 0xBB, 0xBF].pack("C*") + # UTF-8 BOM, WTF?
        "l_english:\n" +
        data.map{|k,v| " #{k}: \"#{v}\"\n"}.join
      )
    end
  end
  def build!
    @target.mkpath
    build_mod_files!
    save_localization!
  end
  def build_mod_files!
    raise "SubclassResponsibility"
  end
  def create_file!(name, content)
    (@target + name).parent.mkpath
    (@target + name).write(content)
  end
  def patch_file!(name)
    new_content = yield(@game.resolve(name).read)
    create_file!(name, new_content)
  end
  def patch_defines_lua!(changes)
    patch_file!("common/defines.lua") do |content|
      changes.each do |variable, orig, updated|
        content.sub!(/^(\s+#{variable}\s*=\s*)(.*?)(\s*,)/) do
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
end
