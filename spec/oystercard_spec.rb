require 'oystercard.rb'

describe Oystercard do
  it 'starts with the balance of zero' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up(value)' do
    it 'increased the oystercard balance by value' do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it 'raises an error if the balance is > £90' do
      expect { subject.top_up(100) }.to raise_error "Cannot top-up by 100: Balance cannot be over £90"
  end

  end
end
