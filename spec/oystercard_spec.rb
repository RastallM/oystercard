require './lib/oystercard'
describe Oystercard do
  describe '#initialized cards' do
    it 'freshly initialized cards should have a balance of 0' do
      expect(subject.balance).to eq 0
    end
  end 

  describe '#top_up' do
    it 'tops up the balance by value' do
      expect { subject.top_up(10) }.to change { subject.balance }.by 10
    end

    it 'tops up a maximum of £90' do
      expect { subject.top_up(100) }.to raise_error "unable to up by 100: over max limit"
    end
  end

  describe '#deduct()' do 
    it 'deducts an amount from the balance' do
     
      expect { subject.deduct(10) }.to change { subject.balance }.by -10
    end
  end

  describe '#injourney?' do 
    it 'initially has in_journey? = false when created' do

      expect(subject.in_journey?).to eq false
    end
  end

  describe '#touch_in' do
    it 'updates @travelling to true' do
      subject.top_up(50)
      subject.touch_in("station")

      expect(subject.travelling).to eq true
    end

    it 'checks that touch_in has updated the entry_station' do
      subject.top_up(50)
      expect { subject.touch_in("bank") }.to change { subject.entry_station }.to eq ("bank")
    end

    it 'raises an error if card balance is lower than £1' do
      expect { subject.touch_in("station")}.to raise_error 'Unable to travel, balance less than £1'
    end
  end

  describe '#touch_out' do
    it 'updates @travelling to false' do
      subject.touch_out
      expect(subject.travelling).to be false
    end

    it 'deduces the minimum fare from @balance' do
      expect { subject.touch_out }.to change { subject.balance }.by -1
    end
  end

end
