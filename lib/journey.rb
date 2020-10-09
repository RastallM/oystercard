class Journey

  attr_accessor :travelling, :current_journey, :journey_history

  def initialize
    @travelling = false
    @current_journey = {}
    @journey_history = []
  end

  def touch_in(station)
    @travelling = true
    @current_journey[:entry_station] = station
  end

  def touch_out(station)
    @travelling = false
    log_travel(station)
  end

  private

  def log_travel(station)
    @current_journey[:exit_station] = station
    @journey_history.push(@current_journey)
    @current_journey = {}
  end

end
