require 'station'

describe Station do
  let(:name) { double :name }
  let(:zone) { double :zone }
  let(:station) { double :station}

  it "exposes name variable" do
    station = Station.new(name, zone)
    expect(station.name).to eq name
  end
  it "exposes zone variable" do
    station = Station.new(name, zone)
    expect(station.zone).to eq zone
  end

  end
