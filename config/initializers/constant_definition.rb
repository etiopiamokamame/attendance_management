def constant_definition
  Dir.glob(Rails.root.join("config", "const", "*")).each do |full_filepath|
    next  unless File.extname(full_filepath) =~ /\A\.ya?ml\z/i
    YAML::load(ERB.new(File.read(full_filepath)).result).each do |key, val|
      klass = self.class.const_set key, Module.new
      val.each do |k, v|
        klass.const_set k, deep_symbolize(v)
      end
    end
  end
end

def deep_symbolize(const)
  return const unless const.is_a? Hash

  const.each_with_object({}) do |(k, v), hash|
    key = if k.to_s =~ /\A[0-9]+\z/
            k
          else
            k.to_sym
          end

    hash[key] = v.is_a?(Hash) ? deep_symbolize(v) : v
  end
end

constant_definition
