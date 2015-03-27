require "tempfile"
require "phantomjs/configuration"
require "phantomjs/version"
require "phantomjs/errors"
require 'pry'

class Phantomjs

  def self.run(path, args=[], opts=[], &block)
    Phantomjs.new.run(path, args, opts, &block)
  end

  def run(path, args=[], opts=[])
    epath = File.expand_path(path)
    raise NoSuchPathError.new(epath) unless File.exist?(epath)
    block = block_given? ? Proc.new : nil
    execute(epath, args, opts, block)
  end

  def self.inline(script, args=[], opts=[], &block)
    Phantomjs.new.inline(script, args, opts, &block)
  end

  def inline(script, args=[], opts=[])
    file = Tempfile.new('script.js')
    file.write(script)
    file.close
    block = block_given? ? Proc.new : nil
    execute(file.path, args, opts, block)
  end

  def self.configure(&block)
    Configuration.configure(&block)
  end

  private

  def execute(path, arguments, opts, block)
    begin
      if block
        IO.popen([exec, opts, path, arguments].flatten).each_line do |line|
          block.call(line)
        end
      else
        IO.popen([exec, opts, path, arguments].flatten).read
      end
    rescue Errno::ENOENT
      raise CommandNotFoundError.new('Phantomjs is not installed')
    end
  end

  def exec
    Phantomjs::Configuration.phantomjs_path
  end
end
