require 'station'

describe Station do 
  
  it 'assigns an instance variable for station name on creation' do
    subject = Station.new("Bank", "Zone 1")
    expect(subject.name).to eq "Bank"
  end

  it 'assigns an instance variable for zone on creation' do
    subject = Station.new("Bank", "Zone 1")

    expect(subject.zone).to eq "Zone 1"
  end

end
