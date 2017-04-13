# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all

user_a = User.create(email: "ahmed.elzeiny@gmail.com")
user_b = User.create(email: "jaden_smith@gmail.com")
user_c = User.create(email: "Da_Fresh_prince@gmail.com")

ShortenedUrl.destroy_all

short_url_a = ShortenedUrl.create!(user_id: user_a.id, long_url: "www.a.com")
short_url_b = ShortenedUrl.create!(user_id: user_b.id, long_url: "www.b.com")
short_url_c = ShortenedUrl.create!(user_id: user_b.id, long_url: "www.c.com")
short_url_d = ShortenedUrl.create!(user_id: user_b.id, long_url: "www.d.com")

Visit.destroy_all

visit_a = Visit.record_visit!(user_a, short_url_a.short_url)
visit_b = Visit.record_visit!(user_b, short_url_b.short_url)
visit_c = Visit.record_visit!(user_c, short_url_c.short_url)
visit_d = Visit.record_visit!(user_a, short_url_b.short_url)
visit_e = Visit.record_visit!(user_b, short_url_a.short_url)

TagTopic.destroy_all

tag_topic_s = TagTopic.create(topic: "Sports")
tag_topic_e = TagTopic.create(topic: "Entertainment")
tag_topic_c = TagTopic.create(topic: "Comedy")
tag_topic_m = TagTopic.create(topic: "Movies")

Tagging.destroy_all

tagging_a = Tagging.create(tag_topic_id: tag_topic_s.id,short_url_id: short_url_a.id)
tagging_b = Tagging.create(tag_topic_id: tag_topic_e.id,short_url_id: short_url_b.id)
tagging_c = Tagging.create(tag_topic_id: tag_topic_c.id,short_url_id: short_url_c.id)
tagging_e = Tagging.create(tag_topic_id: tag_topic_m.id,short_url_id: short_url_d.id)
tagging_f = Tagging.create(tag_topic_id: tag_topic_s.id,short_url_id: short_url_b.id)
