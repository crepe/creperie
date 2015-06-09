# Configure ActiveRecord::DatabaseTasks so they work outside of Rails.
databases = YAML.load(ERB.new(File.read('config/database.yml')).result)

ActiveRecord::Tasks::DatabaseTasks.migrations_paths = [Crepe.root.join('db', 'migrate')]
ActiveRecord::Tasks::DatabaseTasks.database_configuration = databases
ActiveRecord::Tasks::DatabaseTasks.seed_loader = Crepe.application
ActiveRecord::Tasks::DatabaseTasks.db_dir = Crepe.root.join('db')
ActiveRecord::Tasks::DatabaseTasks.root = Crepe.root
ActiveRecord::Tasks::DatabaseTasks.env = Crepe.env

# Loads the environment for rake tasks that need it.
task :environment do
  require File.expand_path('../../../config/application', __FILE__)
end

# Some database tasks in ActiveRecord unfortunately require a Rails.env
module Rails
  def self.env
    Crepe.env
  end
end
