# encoding: utf-8

require 'crepe'

module Dummy
  class API < Crepe::API
    respond_to :json

    # curl 0.0.0.0:9292/
    # => {"hello":"world"}
    get do
      { hello: 'world' }
    end

    # Mount your other APIs here
    # mount UsersAPI => :users
  end
end

# Your Crepe is ready.
run Dummy::API
