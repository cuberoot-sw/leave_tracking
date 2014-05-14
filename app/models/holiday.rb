class Holiday < ActiveRecord::Base
  belongs_to :setting

  validates_uniqueness_of :date
end
