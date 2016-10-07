require 'journey'
require 'oystercard'

describe Journey do
  subject(:journey) { Journey.new }
  let(:start_journey) { double :start_journey }
  let(:end_journey) { double :end_journey }
  let(:entry_station) { double :entry_station }
  let(:journey_history) { double :journey_history }
  let(:current_journey) { double(entry_station: nil, exit_station: nil) }
  let(:oystercard) { double :oystercard }

  before do
    oystercard = Oystercard.new
    oystercard.top_up(10)
  end

describe '#starting_journey' do

  it 'record entry station' do
    journey.starting_journey('southwark')
    expect(journey.entry_station).to eq 'southwark'
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
    journey.starting_journey("station")
    expect(journey).not_to be_complete
  end

  it 'confirms if the journey is complete' do
    journey.starting_journey("station")
    journey.ending_journey("station")
    expect(journey).to be_complete
  end
end

  describe '#fare' do
    context 'when the journey is complete' do
      it 'returns the minumum fare' do
        journey.starting_journey("station")
        journey.ending_journey("station")
        expect(journey.fare).to eq Journey::MIN_FARE
      end
    end
    context 'when the journey is incomplete' do
      it 'returns the penalty fare' do
        journey.ending_journey("station")
        expect(journey.fare).to eq Journey::PENALTY_FARE
      end
    end
  end


end
