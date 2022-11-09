class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def bark!
    puts "bark!"
  end
end
