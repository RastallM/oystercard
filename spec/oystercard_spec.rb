require "oystercard.rb"

describe Oystercard do
  it "starts with the balance of zero" do
    expect(subject.balance).to eq 0
  end
end
