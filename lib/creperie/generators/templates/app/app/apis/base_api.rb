# This is the class that all other Crêpe APIs should inherit from. It defines
# a shared configuration and helper methods that should be used across your
# entire Crepe application.

class BaseAPI < Crepe::API
  # Catch ActiveRecord::RecordNotFound exceptions with a 404 response.
  rescue_from(ActiveRecord::RecordNotFound) { error! :not_found }

  # Add shared helper methods to ApplicationHelper, or create your own
  # additional helper classes and include them here.
  helper ApplicationHelper
end
