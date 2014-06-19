require 'spec_helper'
require 'creperie/loader'

describe Creperie::Loader do
  let!(:pwd) { Dir.pwd }

  context 'when in a crepe app' do
    before { Dir.chdir 'spec/support/dummy' }

    describe '.crepe_app?' do
      subject { Creperie::Loader.crepe_app? }

      it { is_expected.to be_truthy }
    end

    describe '.config_ru' do
      subject { Creperie::Loader.config_ru }

      it { is_expected.to match('spec/support/dummy/config.ru') }
    end

    describe 'Gemfile' do
      subject { Creperie::Loader.gemfile }

      it { is_expected.to match('spec/support/dummy/Gemfile') }
    end

    after { Dir.chdir(pwd) }
  end

  context 'when not in a crepe app' do
    describe '.crepe_app?' do
      subject { Creperie::Loader.crepe_app? }

      it { is_expected.to be_falsy }
    end

    describe '.config_ru' do
      subject { Creperie::Loader.config_ru }

      it { is_expected.to be_nil }
    end

    describe 'Gemfile' do
      subject { Creperie::Loader.gemfile }

      it { is_expected.to match('creperie/Gemfile') }
    end
  end
end
