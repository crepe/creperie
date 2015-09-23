require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/console'

describe Creperie::Commands::Console do
  before do
    @old_rack_env  = ENV['RACK_ENV']
    @old_crepe_env = ENV['CREPE_ENV']
  end
  after do
    ENV['RACK_ENV']  = @old_rack_env
    ENV['CREPE_ENV'] = @old_crepe_env
  end

  context 'outside of a Crepe app' do
    it 'is not detected' do
      expect(Creperie::CLI.find_subcommand('console')).to be_nil
    end
  end

  context 'inside of a Crepe app' do
    let(:dummy)   { File.expand_path('../../support/dummy', __FILE__) }
    let(:console) { Creperie::Commands::Console.new({}) }

    before do
      @old_pwd = Dir.pwd
      Dir.chdir dummy
    end

    it 'starts a Rack::Console' do
      expect(Rack::Console).to receive(:start).with({
        environment: 'development',
        config:      "#{dummy}/config.ru"
      })

      console.run([])
    end

    it 'proxies the --config option to Rack::Console' do
      Dir.chdir @old_pwd

      expect(Rack::Console).to receive(:start).with({
        environment: 'development',
        config: "#{dummy}/config.ru"
      })

      console.run(['--config', "#{dummy}/config.ru"])
    end

    it 'proxies the --include option to Rack::Console' do
      expect(Rack::Console).to receive(:start).with({
        environment: 'development',
        config: "#{dummy}/config.ru",
        include: 'bin:vendor'
      })

      console.run(['--include', 'bin:vendor'])
    end

    it 'proxies the --require option to Rack::Console' do
      expect(Rack::Console).to receive(:start).with({
        environment: 'development',
        config: "#{dummy}/config.ru",
        require: 'json'
      })

      console.run(['--require', 'json'])
    end

    it 'passes the [ENVIRONMENT] argument to Rack::Console' do
      expect(Rack::Console).to receive(:start).with({
        config: "#{dummy}/config.ru",
        environment: 'test'
      })

      console.run(['test'])
    end

    it 'defers the [ENVIRONMENT] argument to $RACK_ENV' do
      ENV['CREPE_ENV'] = nil
      ENV['RACK_ENV'] = 'test'

      expect(Rack::Console).to receive(:start).with({
        config: "#{dummy}/config.ru",
        environment: 'test'
      })

      console.run([])
    end

    it 'defers the [ENVIRONMENT] argument to $CREPE_ENV' do
      ENV['CREPE_ENV'] = 'production'
      ENV['RACK_ENV'] = 'test'

      expect(Rack::Console).to receive(:start).with({
        config: "#{dummy}/config.ru",
        environment: 'production'
      })

      console.run([])
    end

    after { Dir.chdir @old_pwd }
  end
end
