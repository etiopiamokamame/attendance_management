def constant_definition(filename)
  YAML::load(ERB.new(File.read(Rails.root.join("config", filename))).result).each do |key, val|
    klass = self.class.const_set key, Module.new
    val.each do |k, v|
      klass.const_set k, v.is_a?(Hash) ? v.deep_symbolize_keys : v
    end
  end
end

constant_definition("constants.yml")
