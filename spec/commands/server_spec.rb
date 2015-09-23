require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/server'
require 'rack'

describe Creperie::Commands::Server do
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
      expect(Creperie::CLI.find_subcommand('server')).to be_nil
    end
  end

  context 'inside of a Crepe app' do
    let(:server) { Creperie::Commands::Server.new(Dir.pwd, {}) }

    before do
      allow(Creperie::Loader).to receive(:crepe_app?) { true }
    end

    it 'calls out to Rack::Server with passed/default options' do
      opts = double
      allow(opts).to receive(:[])

      allow(server).to        receive(:options).and_return(opts)
      expect(Rack::Server).to receive(:start).with(opts)

      server.run([])
    end

    it 'watches files for changes' do
      listener = double
      expect(listener).to receive(:start)

      expect(Rack::Server).to receive(:start)
      expect(Listen).to receive(:to).with(Dir.pwd, only: /\.(rb|ru|yml)$/).
                                     and_return(listener)

      server.run([])
    end

    context 'options' do
      before { allow(Rack::Server).to receive(:start) }
      let(:options) { server.send(:options) }

      it 'takes --server (or -s)' do
        server.run(['--server', 'puma'])
        expect(options[:server]).to eq('puma')

        server.run(['-s',       'puma'])
        expect(options[:server]).to eq('puma')
      end

      it 'takes a --host (or -o) option' do
        server.run(['--host', 'localhost'])
        expect(options[:Host]).to eq('localhost')

        server.run(['-o',     'localhost'])
        expect(options[:Host]).to eq('localhost')
      end

      it 'takes a --port (or -p) option' do
        server.run(['--port', '3000'])
        expect(options[:Port]).to eq(3000)

        server.run(['-p',     '3000'])
        expect(options[:Port]).to eq(3000)
      end

      it 'takes a --env (or -E) option' do
        server.run(['--env', 'production'])
        expect(options[:environment]).to eq('production')

        server.run(['-E',    'production'])
        expect(options[:environment]).to eq('production')

        expect(ENV['RACK_ENV']).to eq('production')
      end

      it 'defers environment to $RACK_ENV' do
        ENV['CREPE_ENV'] = nil
        ENV['RACK_ENV'] = 'staging'

        server.run([])
        expect(options[:environment]).to eq('staging')
      end

      it 'defers environment to $CREPE_ENV' do
        ENV['CREPE_ENV'] = 'production'
        ENV['RACK_ENV'] = 'staging'

        server.run([])
        expect(options[:environment]).to eq('production')
      end

      it 'takes a --pid (or -P) option' do
        server.run(['--pid', 'tmp/crepe.pid'])
        expect(options[:pid]).to eq('tmp/crepe.pid')

        server.run(['-P',    'tmp/crepe.pid'])
        expect(options[:pid]).to eq('tmp/crepe.pid')
      end

      it 'takes a --daemonize (or -D) option' do
        server.run(['--daemonize'])
        expect(options[:daemonize]).to be_truthy

        server.run(['-D'])
        expect(options[:daemonize]).to be_truthy
      end

      it 'takes a --config (or -c) options' do
        server.run(['--config', 'crepe.ru'])
        expect(options[:config]).to eq('crepe.ru')

        server.run(['-c',       'crepe.ru'])
        expect(options[:config]).to eq('crepe.ru')
      end
    end
  end
end
