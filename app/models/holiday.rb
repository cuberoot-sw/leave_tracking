class Holiday < ActiveRecord::Base
  belongs_to :setting

  validates_uniqueness_of :date
  validates_presence_of :date, :occasion
  self.per_page = 10
end
