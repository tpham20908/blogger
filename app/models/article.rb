class Article < ApplicationRecord
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings
  has_attached_file :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(",").collect do |s|
                  s.strip.downcase
                end.uniq
    new_or_found_tags = tag_names.collect do |name|
                          Tag.find_or_create_by(name: name)
                        end
    self.tags = new_or_found_tags
  end
end
