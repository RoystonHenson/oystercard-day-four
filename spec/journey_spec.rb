require 'journey'
require 'oystercard'

describe Journey do
  subject(:journey) { Journey.new(:entry_station) }
  let(:entry_station) { double :entry_station }

describe '#initialize' do
  it 'record entry station' do
    expect(journey.entry_station).to eq :entry_station
  end
end

describe '#ending_journey' do
  it 'record exit station' do
    journey.ending_journey('bank')
    expect(journey.exit_station).to eq 'bank'
  end
end

describe '#complete?' do
  it 'confirms if the journey is incomplete' do
    expect(journey).not_to be_complete
  end

  it 'confirms if the journey is complete' do
    journey.ending_journey("station")
    expect(journey).to be_complete
  end
end

  describe '#fare' do
    context 'when the journey is complete' do
      it 'returns the minumum fare' do
        journey.ending_journey("station")
        expect(journey.fare).to eq Journey::MIN_FARE
      end
    end
    context 'when the journey is incomplete' do
      it 'returns the penalty fare' do
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end
end
