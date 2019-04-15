# Insipired from https://stackoverflow.com/a/6407200
require_relative 'reox_file.rb'
class ReoxIO
   $LOG_SEPARATOR = " --> ".freeze
   def initialize(*streams)
     @streams = streams
     @verbose = true
   end 

   def write(*content)
     @streams.each do |stream| 
      if @verbose and stream.is_a? ReoxFile
        stream.write(caller[2],$LOG_SEPARATOR,*content)
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
      
end