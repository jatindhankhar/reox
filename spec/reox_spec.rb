require 'reox'

RSpec.describe Reox do
  def verify_recording(msg, verbose = false)
    file_content = File.read('output.log')
    if verbose
      expect(file_content.strip).to include(msg)
      expect(file_content.strip).to_not eq(msg)
    else
      expect(file_content.strip).to eq(msg)
    end
  end

  before(:each) do
    File.delete('output.log') if File.exist?('output.log')
  end

  describe '#record' do
    it 'records the content in non-verbose mode inside the block by default' do
      msg = 'It will be recorded'
      Reox.record do
        puts msg
      end
      verify_recording(msg)
    end

    it 'records the content verbosely inside the block if verbose option is provided' do
      msg = 'It will be recorded verbosely'
      Reox.record(verbose: true) do
        puts msg
      end
      verify_recording(msg, true)
    end
  end

  describe '#record!' do
    it 'records the content in non-verbose mode inside the block by default' do
      msg = 'It will be recorded'
      Reox.record!
      puts msg
      Reox.stop!
      verify_recording(msg)
    end

    it 'records the content verbosely inside the block if verbose option is provided' do
      msg = 'It will be recorded verbosely'
      Reox.record!(verbose: true)
      puts msg
      Reox.stop!
      verify_recording(msg, true)
    end
  end
end
