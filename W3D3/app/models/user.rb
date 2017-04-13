# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true

  has_many :sumbitted_urls,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "ShortenedUrl"

  has_many :visits,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Visit"



end
