class Oystercard
  attr_reader :balance, :travelling, :entry_station, :exit_station, :journey_history
  MAX_VALUE = 90
  MIN_VALUE = 1

  def initialize
    @balance = 0
    @travelling = false
    @entry_station = nil
    @journey_history = []
  end

  def max_value?(value)
    (@balance + value) > MAX_VALUE
  end

  def lack_of_funds
    @balance < MIN_VALUE
  end

  def top_up(value)
    fail "unable to up by #{value}: over max limit" if max_value?(value)

    @balance += value
  end

  def in_journey?
    @entry_station != nil
  end

  def touch_in(station)
    fail 'Unable to travel, balance less than £1' if lack_of_funds

    @entry_station = station
    @travelling = true
  end

  def touch_out(station)
    @balance -= 1
    @exit_station = station
    add_history
    @travelling = false
  end

  def add_history
    @journey_history.push({entry_station: @entry_station, exit_station: @exit_station})
  end

  #private

  def deduct(value)
    @balance -= value
  end

end
