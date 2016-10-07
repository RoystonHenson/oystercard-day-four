require 'oystercard'

describe Oystercard do
  subject(:oystercard) { Oystercard.new }
  let(:station) { double :station }

  it 'has a starting balance of 0' do
    oystercard.deduct(10)
    expect(oystercard.balance).to eq(0)
  end

  before do
    oystercard.top_up(10)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'tops up balance' do
      top_up_value = 10
      expect { oystercard.top_up(top_up_value) }
      .to change { oystercard.balance }.by top_up_value
    end

    it 'enforces maximum balance' do
      error = 'Maximum balance exceeded'
      top_up_value = 125
      expect { oystercard.top_up(top_up_value) }.to raise_error error
    end
  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'deducts balance' do
      deducted_value = Journey::MIN_FARE
      expect { oystercard.deduct(deducted_value) }
      .to change { oystercard.balance }.by(- deducted_value)
    end
  end

  describe '#touch_in' do
    it 'checks minimum balance' do
      oystercard.deduct(10)
      error = 'Insuficient balance'
      expect { oystercard.touch_in(station) }.to raise_error error
    end
    it 'start a new journey' do
      oystercard.touch_in(station)
      expect(oystercard.current_journey).to be_a_kind_of Journey
    end
    it 'get station info' do
      oystercard.touch_in('bank')
      expect(oystercard.current_journey.entry_station).to eq 'bank'
    end
  end

  describe '#touch_out' do
    context "when touched in" do
      it 'deduct correct fare' do
        oystercard.touch_in(station)

        expect { oystercard.touch_out(station) }
        .to change { oystercard.balance }.by(-Journey::MIN_FARE)
      end
    end
    context 'when not touched in' do
      it 'charges penalty fare' do
        expect { oystercard.touch_out(station) }
        .to change { oystercard.balance }.by(-Journey::PENALTY_FARE)
      end
    end
  end

  describe 'journey history' do
    it 'checks that journey history is empty when card is created' do
      expect(oystercard.journey_history).to eq []
    end

    it 'checks that touching in and out stores a journey' do
      oystercard.touch_in('southwark')
      oystercard.touch_out('aldgate')
      expect(oystercard.journey_history).to eq [oystercard.current_journey]
    end
  end
end
