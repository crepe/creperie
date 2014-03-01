# Configure ActiveRecord::DatabaseTasks so they work outside of Rails.
databases = YAML.load(ERB.new(File.read('config/database.yml')).result)

ActiveRecord::Tasks::DatabaseTasks.database_configuration = databases
ActiveRecord::Tasks::DatabaseTasks.db_dir = Crepe.root.join('db')
ActiveRecord::Tasks::DatabaseTasks.root   = Crepe.root
ActiveRecord::Tasks::DatabaseTasks.env    = Crepe.env

# Loads the environment for rake tasks that need it.
task :environment do
  # Set up environment
  ActiveRecord::Tasks::DatabaseTasks.db_dir = Crepe.root.join('db')

  # Establish a connection to the correct database
  ActiveRecord::Base.establish_connection(databases[Crepe.env])

  # Set up logging
  log = Crepe.root.join('log', "#{Crepe.env}.log")
  ActiveRecord::Base.logger = Logger.new(File.open(log, 'w+'))
end

# Some database tasks in ActiveRecord unfortunately require a Rails.env
module Rails
  def self.env
    Crepe.env
  end
end
