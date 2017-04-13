# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string           not null
#  long_url   :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, presence: true, uniqueness: true
  validates :long_url, presence: true
  validates :user_id, presence: true

  def self.random_code
    loop do
      val = SecureRandom::urlsafe_base64
      return val unless self.exists?(short_url: val)
    end
    nil
  end

  def self.find_by_short_url(short_url)
    ShortenedUrl.find_by(short_url: short_url)
  end

  def self.create!(options)
    options["short_url"] = self.random_code
    ShortenedUrl.create(options)
  end

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "User"

  has_many :visits,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: "Visit"

  has_many :users_visited,
  through: :visits,
  source: :user

  has_many :uniq_visitors,
    Proc.new { distinct },
    through: :visits,
    source: :user

  has_many :taggings,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "Tagging"

  has_many :tag_topics,
    through: :taggings,
    source: :tag_topic

  def num_clicks
    users_visited.count
    # Visit.where(short_url_id: id).count
  end

  def num_uniques
    uniq_visitors.count
    # Visit.select(:user_id).distinct.where(short_url_id: id).count
  end

  def num_recent_uniques
    # Visit.select(:id, :updated_at, :user_id).distinct.where(short_url_id: id).limit(2).order('updated_at').reverse_order
    uniq_visitors.where("visits.updated_at >= ?", 10.minutes.ago).count
  end

end
