# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Visit < ActiveRecord::Base
  validates :user_id, presence: true
  validates :short_url_id, presence: true

  def self.record_visit!(user, shortened_url)
    short = ShortenedUrl.find_by(short_url: shortened_url)
    Visit.create(user_id: user.id, short_url_id: short.id)
  end

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "ShortenedUrl"

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User"
end
