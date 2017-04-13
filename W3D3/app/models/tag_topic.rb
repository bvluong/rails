# == Schema Information
#
# Table name: tag_topics
#
#  id         :integer          not null, primary key
#  topic      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#



class TagTopic < ActiveRecord::Base
  validates :topic, presence: true

  has_many :taggings,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: "Tagging"

  has_many :shortened_urls,
    through: :taggings,
    source: :shortened_url

  def popular_links
    # Visit.join(shortened_urls ON shortened_urls.id = Visit.short_url_id).group(short_url_id).order()
    shortened_urls.select("short_url, COUNT(short_url) AS num_visits").joins(:visits).group(:short_url).order("num_visits").each do |x|
      p [x.short_url, x.num_visits]
    end
    # Visit.joins(shortened_urls)



    # Tagging.popular_links_by_id(id)
  end

end
