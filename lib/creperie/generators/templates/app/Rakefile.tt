require File.expand_path('../config/boot', __FILE__)
require 'crepe'

Bundler.require(:default, Crepe.env)

# Load ActiveRecord Rake tasks
load 'active_record/railties/databases.rake'

# Load all Rake tasks in lib/tasks/
Dir['lib/tasks/**/*.rake'].each { |task| load task }
