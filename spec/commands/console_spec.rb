require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/console'

require 'pry'

describe Creperie::Commands::Console do
  context 'outside of a Crêpe app' do
    it 'is not detected' do
      expect(Creperie::CLI.find_subcommand('console')).to be_nil
    end
  end

  context 'inside of a Crêpe app' do
    let(:dummy)   { File.expand_path('../../support/dummy', __FILE__) }
    let(:console) { Creperie::Commands::Console.new(dummy, {}) }

    before do
      allow(Creperie::Loader).to receive(:config_ru) { "#{dummy}/config.ru" }
    end

    it 'loads config.ru and starts Pry' do
      expect(Rack::Builder).to receive(:parse_file).with("#{dummy}/config.ru")
      expect(Pry).to receive(:start)

      console.run([])
    end

    it 'takes a --env (or -E) option' do
      expect(Rack::Builder).to receive(:parse_file).with("#{dummy}/config.ru").twice
      expect(Pry).to receive(:start).twice

      console.run(['--env', 'production'])
      console.run(['-E',    'production'])

      expect(ENV['CREPE_ENV']).to eq('production')
    end
  end
end
