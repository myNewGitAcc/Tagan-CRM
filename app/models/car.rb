class Car < ActiveRecord::Base
  belongs_to :user
  acts_as_api

  api_accessible :basic do |t|
    t.add :id
    t.add :name
    t.add :is_stock
    t.add :max_speed
    t.add :price
    t.add :user_id
    t.add :created_at
  end
end
