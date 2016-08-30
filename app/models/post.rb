class Post < ApplicationRecord
  belongs_to :user
  has_many :images, class_name: "PostImage"
end
