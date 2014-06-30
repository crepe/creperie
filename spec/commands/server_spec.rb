require 'spec_helper'
require 'creperie/cli'
require 'creperie/commands/server'
require 'rack'

describe Creperie::Commands::Server do
  context 'outside of a Crêpe app' do
    it 'is not detected' do
      expect(Creperie::CLI.find_subcommand('server')).to be_nil
    end
  end

  context 'inside of a Crêpe app' do
    let(:server) { Creperie::Commands::Server.new(Dir.pwd, {}) }

    before do
      allow(Creperie::Loader).to receive(:crepe_app?) { true }
    end

    it 'calls out to Rack::Server with passed/default options' do
      opts = double
      expect(server).to       receive(:options).and_return(opts)
      expect(Rack::Server).to receive(:start).with(opts)

      server.run([])
    end

    context 'options' do
      before { allow(Rack::Server).to receive(:start) }

      it 'takes --server (or -s)' do
        server.run(['--server', 'puma'])
        expect(server.options[:server]).to eq('puma')

        server.run(['-s',       'puma'])
        expect(server.options[:server]).to eq('puma')
      end

      it 'takes a --host (or -o) option' do
        server.run(['--host', 'localhost'])
        expect(server.options[:Host]).to eq('localhost')

        server.run(['-o',     'localhost'])
        expect(server.options[:Host]).to eq('localhost')
      end

      it 'takes a --port (or -p) option' do
        server.run(['--port', '3000'])
        expect(server.options[:Port]).to eq(3000)

        server.run(['-p',     '3000'])
        expect(server.options[:Port]).to eq(3000)
      end

      it 'takes a --env (or -E) option' do
        server.run(['--env', 'production'])
        expect(server.options[:environment]).to eq('production')

        server.run(['-E',    'production'])
        expect(server.options[:environment]).to eq('production')
      end

      it 'takes a --pid (or -P) option' do
        server.run(['--pid', 'tmp/crepe.pid'])
        expect(server.options[:pid]).to eq('tmp/crepe.pid')

        server.run(['-P',    'tmp/crepe.pid'])
        expect(server.options[:pid]).to eq('tmp/crepe.pid')
      end

      it 'takes a --daemonize (or -D) option' do
        server.run(['--daemonize'])
        expect(server.options[:daemonize]).to be_truthy

        server.run(['-D'])
        expect(server.options[:daemonize]).to be_truthy
      end

      it 'takes a --config (or -c) options' do
        server.run(['--config', 'crepe.ru'])
        expect(server.options[:config]).to eq('crepe.ru')

        server.run(['-c',       'crepe.ru'])
        expect(server.options[:config]).to eq('crepe.ru')
      end
    end
  end
end