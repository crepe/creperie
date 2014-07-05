require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new :spec do |t|
  t.verbose = false
end

require 'cane/rake_task'
Cane::RakeTask.new(:quality)

task default: [:spec, :quality]
