require_relative 'reox_io.rb'
require_relative 'reox_file.rb'

class Reox
    DEFAULT_RECORDING_PATH = "recordings" 

    def initialize(recording_path)
        @recording_paths = recording_path || DEFAULT_RECORDING_PATH  
    end

    def self.record 
        input_log,output_log,error_log = setup_files
        $stdout = ReoxIO.new(STDOUT,output_log)
        $stderr = ReoxIO.new(STDERR,error_log)
        yield
    end


    private 

    def self.setup_files
        ["input.log","output.log","error.log"].map do |file_name|
            self.setup_file(file_name)
        end 
    end

    def self.setup_file(file_name)
        file = ReoxFile.open(File.join(__dir__,file_name),"a")
        file.sync = true
        file
    end
end