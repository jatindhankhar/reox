require_relative 'reox_io'
require_relative 'reox_file'

# Reox is the driver class, it hijacks and restore streams
class Reox
  FILE_NAMES = %w[output.log error.log].freeze
  def self.record(opts = {})
    hijack_streams(opts)
    yield
    restore_streams
  end

  def self.record!(opts = {})
    hijack_streams(opts)
  end

  def self.stop!
    restore_streams
  end

  private_class_method def self.hijack_streams(opts)
    output_log, error_log = setup_files
    $stdout = ReoxIO.new([STDOUT, output_log], opts.merge!(type: ReoxIO::OUT)) unless $stdout.is_a? ReoxIO
    $stderr = ReoxIO.new([STDERR, error_log], opts.merge!(type: ReoxIO::ERR)) unless $stderr.is_a? ReoxIO
  end

  private_class_method def self.restore_streams
    $stdout = STDOUT if $stdout.is_a? ReoxIO
    $stderr = STDERR if $stderr.is_a? ReoxIO
  end

  private_class_method def self.setup_files
    FILE_NAMES.map do |file_name|
      setup_file(file_name)
    end
  end

  private_class_method def self.setup_file(file_name)
    file = ReoxFile.open(File.join(Dir.pwd, file_name), mode: 'a')
    file.sync = true
    file
  end
end
