class Setting < ActiveRecord::Base
  has_many :holidays, dependent: :destroy

  validates_uniqueness_of :year
  validates_presence_of :year
  self.per_page = 10
end
