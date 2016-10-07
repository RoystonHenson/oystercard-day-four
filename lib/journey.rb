require 'station'
require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :journey_history, :current_journey

  def initialize(travel = false)
    @entry_station = nil
    @exit_station = nil
    @travel = travel
  end

  def starting_journey(station)
    @entry_station = station
  end

  def ending_journey(station)
    @exit_station = station
  end

  def in_journey?
    !!entry_station
  end

end
