require 'yaml'


class Configuration

  def initialize(config_name)
    @config = YAML.load(File.open("config/#{config_name}.yml"))
  end

  def sqliTwitterAccount
    puts "test"
    puts @config
    @config['sqliTwitterAccount']
  end

  def devfestTwitterAccount
    @config['devfestTwitterAccount']
  end


end
