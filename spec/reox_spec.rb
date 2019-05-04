require 'reox'

RSpec.describe Reox do
  before(:each) do
    File.delete('output.log') if File.exist?('output.log')
  end

  describe '#record' do
    it 'records the content in non-verbose mode inside the block if no option is provided' do
      msg = 'It will be recorded'
      Reox.record do
        puts msg
      end
      file_content = File.read('output.log')
      expect(file_content.strip).to eq(msg)
    end

    it 'records the content verbosely inside the block if verbose option is provided' do
      msg = 'It will be recorded verbosely'
      Reox.record(verbose: true) do
        puts msg
      end
      file_content = File.read('output.log')
      expect(file_content.strip).to include(msg)
      expect(file_content.strip).to_not eq(msg)
    end
  end
end
