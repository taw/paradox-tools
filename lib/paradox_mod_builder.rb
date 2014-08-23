require "yaml"
require "pathname"

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
  def compare_with_reference!(reference)
    system *%W[diff -wru #{@target} #{reference}]
  end
  def add_localization!(group, tag, name)
    @localization[group] ||= {}
    @localization[group][tag] = name
  end
  def save_localization!
    @localization.each do |group, data|
      raise "NotImplementedYet"
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
  def patch_file!(name)
    new_content = yield(@game.resolve(name).read)
    (@target + name).parent.mkpath
    (@target + name).write(new_content)
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
