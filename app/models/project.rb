class Project < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: :owner_id
  has_many   :donations
  has_many   :donators, class_name: "User", through: :donations

  validates_presence_of :owner, :title, :description
  validates_uniqueness_of :title

  attr_accessible :owner, :title, :description, :hour_goal, :dollar_goal
  
  def hours_donated
    self.donations.inject(0) { |sum, donation| sum += donation.hours }
  end

  def hours_remaining
    hour_goal - hours_donated
  end

  def dollars_donated
    self.donations.inject(0) { |sum, donation| sum += donation.dollar_amount }
  end

  def dollars_remaining
    dollar_goal - dollars_donated
  end
end
