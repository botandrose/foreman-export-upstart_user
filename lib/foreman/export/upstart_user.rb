require "erb"
require "foreman/export"

class Foreman::Export::UpstartUser < Foreman::Export::Upstart
  def initialize location, engine, options={}
    super
    # what a pain in the ass
    # template is obviously not intended to be overriden
    unless @options.has_key?(:template)
      template = File.expand_path("../../../../data/export/upstart_user", __FILE__)
      @options = { :template => template }.merge(@options).freeze
    end
  end

  def export
    super

    Dir["#{location}/#{app}*.conf"].each do |file|
      clean file
    end

    write_template "upstart/master.conf.erb", "#{app}.conf", binding

    engine.each_process do |name, process|
      next if engine.formation[name] < 1
      write_template "upstart/process_master.conf.erb", "#{app}-#{name}.conf", binding

      1.upto(engine.formation[name]) do |num|
        port = engine.port_for(process, num)
        write_template "upstart_user/process.conf.erb", "#{app}-#{name}-#{num}.conf", binding
      end
    end
  end

  def location
    options[:location] || "/home/#{user}/.init"
  end

  def app
    options[:app] || File.basename(Dir.pwd)
  end

  def log
    options[:log] || "log"
  end

  def user
    options[:user] || `whoami`.strip
  end
end
