require './lib/oystercard'
describe Oystercard do
  # WORKING ON USING DOUBLES TO REFACTOR
  # let(:topped_up_card) { instance_double("Oystercard", :balance => 20, :entry_station => nil)}

  # before do
  #   allow(topped_up_card).to receive(:top_up)
  #   allow(topped_up_card).to receive(:touch_in).with(:station)
  #   allow(topped_up_card).to receive(:touch_out)
  #   topped_up_card.top_up(10)
  # end

  describe '#initialized cards' do
    it 'freshly initialized cards should have a balance of 0' do
      expect(subject.balance).to eq 0
    end

    it 'freshly initialized cards should have NO journey history' do
      expect(subject.journey_history).to eq []
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

  describe '#fare()' do
    it 'deducts an amount from the balance' do

      expect { subject.fare(10) }.to change { subject.balance }.by -10
    end
  end

  describe '#injourney?' do
    it 'initially has travelling? = false when created' do

      expect(subject.travelling?).to eq false
    end
  end

  describe '#touch_in' do
    it 'updates @travelling to true' do
      subject.top_up(50)
      subject.touch_in(:station)
      expect(subject.travelling?).to eq true
    end

    it 'checks that touch_in has updated the entry_station' do
      subject.top_up(50)
      expect { subject.touch_in(:station) }.to change { subject.current_journey[:entry_station] }.to eq (:station)
    end

    it 'raises an error if card balance is lower than £1' do
      expect { subject.touch_in(:station)}.to raise_error 'Unable to travel, balance less than £1'
    end
  end

  describe '#touch_out' do
    it 'updates @travelling to false' do
      subject.touch_out(:station)
      expect(subject.travelling?).to be false
    end

    it 'deduces the minimum fare from @balance' do
      expect { subject.touch_out(:station) }.to change { subject.balance }.by -1
    end

    it 'checks that touch_out has updated the exit_station' do
      subject.top_up(50)
      expect { subject.touch_out(:station) }.to change { subject.current_journey[:exit_station]}.to eq (:station)
    end

  end

  describe '@journey_history' do
    it 'adds entry and exit stations to history after touch_in and touch_out' do
      subject.top_up(20)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.journey_history).to eq [ {entry_station: :station, exit_station: :station} ]
    end
  end
end


# #  testing doubles
# describe Oystercard do
#   it "uses a mock with a topped up balance" do
#   topped_up_card = double('oystcard')

#   allow(topped_up_card).to receive(:baance) {10}

#   expect(topped_up_card.baance).to eq 10
#   end
# end
