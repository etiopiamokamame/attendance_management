def constant_definitions
  Dir.glob(Rails.root.join("config", "const", "*")).each do |full_filepath|
    next  unless File.extname(full_filepath) =~ /\A\.ya?ml\z/i
    YAML::load(ERB.new(File.read(full_filepath)).result).each do |key, val|
      klass = self.class.const_set key, Module.new
      val.each do |k, v|
        klass.const_set k, v.is_a?(Hash) ? v.deep_symbolize_keys : v
      end
    end
  end
end

constant_definitions