require_relative "../../lib/paradox_game_modification"

class EU4GameModification < ParadoxGameModification
  def override_defines_lua!(name, overrides)
    create_file!(
      "common/defines/#{name}.lua",
      overrides.map{|key, val| "NDefines.#{key} = #{val}\n"}.join
    )
  end

  def modify_node!(node, *modifications)
    modifications.each do |*path, expected, modified|
      actual = path.inject(node){|n,p| n ? n[p] : nil}
      raise "Node[#{path.join('/')}] expected `#{expected}', got `#{actual}'" unless actual == expected
      path[0..-2].inject(node){|n,p| n[p]}[path[-1]] = modified
    end
  end

  def soft_patch_defines_lua!(name, *changes)
    orig_lua = resolve("common/defines.lua").read
    changes.each do |full_variable, orig, updated|
      base_variable = full_variable.sub(/.*\./, "")
      if orig_lua =~ /^(\s+#{base_variable}\s*=\s*)(.*?)(\s*,|\s*$)/
        if $2 == orig.to_s
          # OK
        else
          raise "Tried to change `#{full_variable}' from `#{orig}' to `#{updated}', but is it `#{$2}' instead"
        end
      else
        raise("Tried to change `#{full_variable}' from `#{orig}' to `#{updated}', can't find it in the file")
      end
    end

    override_defines_lua!(name,
      Hash[changes.map{|var,_,nv| [var,nv]}]
    )
  end
end
