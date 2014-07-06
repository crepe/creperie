require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/console'

describe Creperie::Commands::Console do
  context 'outside of a Crêpe app' do
    it 'is not detected' do
      expect(Creperie::CLI.find_subcommand('console')).to be_nil
    end
  end

  context 'inside of a Crêpe app' do
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

    after { Dir.chdir @old_pwd }
  end
end
