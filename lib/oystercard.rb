class Oystercard
  attr_reader :balance, :current_journey, :journey_history
  MAX_VALUE = 90
  MIN_VALUE = 1

  def initialize
    @balance = 0
    @journey = Journey.new
    @current_journey ={}
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

  def travelling?
    @journey.travelling
  end

  def touch_in(station)
    fail 'Unable to travel, balance less than £1' if lack_of_funds

    @current_journey[:entry_station] = station
    @journey.touch_in(station)
  end

  def touch_out(station)
    fare
    @current_journey[:exit_station] = station
    add_history
    @journey.touch_out(station)
  end

  def add_history
    @journey_history.push(@current_journey)
  end

  #private

  def fare(value = MIN_VALUE)
    @balance -= value
  end

end
