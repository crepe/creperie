# This is the class that all other Crepe APIs should inherit from. It defines
# a shared configuration and helper methods that should be used across your
# entire Crepe application.

class BaseAPI < Crepe::API
  # Return ActiveRecord connections to the pool when requests terminate.
  use ActiveRecord::ConnectionAdapters::ConnectionManagement

  # Catch ActiveRecord::RecordNotFound exceptions with a 404 response.
  rescue_from(ActiveRecord::RecordNotFound) do |e|
    error! :not_found, e.message
  end

  # Catch ActiveRecord::RecordInvalid exceptions with a 422 response.
  rescue_from(ActiveRecord::RecordInvalid) do |e|
    error! :unprocessable_entity, e.message, errors: e.record.errors
  end

  # Add shared helper methods to ApplicationHelper, or create your own
  # additional application-wide helper modules and include them here.
  helper ApplicationHelper
end
