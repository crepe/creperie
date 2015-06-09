# Define root-level routes here, or mount your sub-apis that you've defined in
# the app/apis/ directory. Additionally, you can mount any Rack application.
Crepe.application.routes do
  respond_to :json

  # curl 0.0.0.0:9292/
  # => {"hello":"world"}
  get do
    { hello: 'world' }
  end

  # Mount your other APIs here
  # mount UsersAPI => :users
end
