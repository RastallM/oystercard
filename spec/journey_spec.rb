require 'journey'

describe Journey do
  

  describe '#travelling?' do 
  let(:station)     { double('station') }

    context 'when a card has been touched in'
    it 'returns true ' do
      journey = Journey.new
      expect{ journey.touch_in(station) }.to change(journey, :travelling).from(false).to(true)
    end

    context 'when a card has been touched out'
    it 'returns false' do
      journey = Journey.new
      journey.touch_in(station)
      expect{ journey.touch_out(station) }.to change(journey, :travelling).from(true).to(false)
    end

  end

  describe '#current journey' do
    let(:station)     { double('station') }
   
    it '@current_journey is updated with the entry station on touch in' do
      journey = Journey.new
      journey.touch_in(station)
      expect(journey.current_journey[:entry_station]).to eq station
    end

 
  end

  describe '@journey_history' do
    let(:station)     { double('station') }
    let(:current_journey)   { {:entry_station => station, :exit_station => station}}
    
    it 'logs a complete journey has on touch out' do
      journey = Journey.new
      journey.touch_in(station)
      journey.touch_out(station)
      expect(journey.journey_history).to eq [current_journey]
    end
  end
end