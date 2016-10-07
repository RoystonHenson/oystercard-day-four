require 'station'
require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station, :ending_journey

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station=nil,exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def ending_journey(station)
    @exit_station = station
  end

  def complete?
    @entry_station && @exit_station
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

end
