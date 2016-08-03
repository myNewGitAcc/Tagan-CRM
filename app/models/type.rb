class Type < ActiveRecord::Base
  has_one :inventory, foreign_key: :type_id
end