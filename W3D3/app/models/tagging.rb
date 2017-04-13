# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  short_url_id :integer          not null
#  tag_topic_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Tagging < ActiveRecord::Base

  belongs_to :tag_topic,
    primary_key: :id,
    foreign_key: :tag_topic_id,
    class_name: "TagTopic"

  belongs_to :shortened_url,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: "ShortenedUrl"

  def self.popular_links_by_id(id)
    Visit.select(:id, :updated_at, :short_url_id).distinct.where(tag_topic_id: id).limit(3).order('updated_at').reverse_order
  end
end
