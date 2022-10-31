class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def as_error_json
    { errors: errors.full_messages }
  end
end
