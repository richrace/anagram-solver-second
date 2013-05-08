class Dictionary < ActiveRecord::Base
  attr_accessible :filename, :grouped, :original, :time_taken
  serialize :grouped
  serialize :original

  has_many :previous_searches, :dependent => :destroy

  validates :grouped, :presence => true
  validates :original, :presence => true
  validates :time_taken, :presence => true
  validates :filename, :presence => true

end
