# Insipired from https://stackoverflow.com/a/6407200
require 'logger'
require_relative 'reox_file'

# ReoxIO mimics the IO class for STDOUT and STDERR,
# As well as injects the ReoxFile with logs
class ReoxIO
  OUT = :out
  ERR = :err

  def initialize(streams, opts = {})
    @streams = streams
    @verbose = opts[:verbose] || false
    @type = opts[:type] || OUT
    @formatter = Logger::Formatter.new if @verbose
  end

  def write(*content)
    @streams.each do |stream|
      if @verbose && stream.is_a?(ReoxFile) && !content.join.strip.empty?
        message = get_log_message(severity_level, caller(3..3).first, content.join)
        stream.write(message)
      else
        stream.write(*content)
      end
    end
  end

  def flush
    @streams.each(&:flush)
  end

  def close
    @streams.each(&:close)
  end

  private

  def severity_level
    @type == OUT ? :INFO : :ERROR
  end

  def get_log_message(severity, progname, msg)
    @formatter.call(severity, Time.now, progname, msg)
  end
end
