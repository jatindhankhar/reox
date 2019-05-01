require 'reox'

RSpec.describe Reox do
  before(:each) do
    File.delete('output.log') if File.exist?('output.log')
  end

  describe '#record' do
    it 'records the content inside the block' do
      Reox.record do
        puts 'It will be recorded'
      end
      expect(File.read('output.log').strip).to eq('It will be recorded')
    end
  end
end
