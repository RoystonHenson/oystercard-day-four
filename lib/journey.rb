require 'station'
require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def starting_journey(station)
    @entry_station = station
  end

  def ending_journey(station)
    @exit_station = station
  end

  def complete?
    @entry_station && @exit_station
  end

end
