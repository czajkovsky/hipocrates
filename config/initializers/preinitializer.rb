sec_config = YAML.load(File.read(File.expand_path('../../secret_config.yml',     __FILE__)))
SecretConfig = RecursiveOpenStruct.new(sec_config)
