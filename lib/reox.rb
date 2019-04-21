require_relative 'reox_io'
require_relative 'reox_file'

class Reox
    
    FILE_NAMES = %w(input.log output.log error.log)

    def self.record 
        hijack_streams
        yield
        restore_streams
    end


    def self.record!
        hijack_streams
    end

    def self.stop!
        restore_streams
    end 


    private 

    def self.hijack_streams
        input_log,output_log,error_log = setup_files
        $stdout = ReoxIO.new(STDOUT,output_log) unless $stdout.is_a? ReoxIO
        $stderr = ReoxIO.new(STDERR,error_log) unless $stderr.is_a? ReoxIO
    end 

    def self.restore_streams
        $stdout = STDOUT if $stdout.is_a? ReoxIO
        $stderr = STDOUT if $stderr.is_a? ReoxIO
    end 

    def self.setup_files
        FILE_NAMES.map do |file_name|
            setup_file(file_name)
        end 
    end

    def self.setup_file(file_name)
        file = ReoxFile.open(File.join(__dir__,file_name),mode: 'a')
        file.sync = true
        file
    end
end