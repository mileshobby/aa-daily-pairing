class Post < ApplicationRecord
  validates :title, :subs, :author, presence: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :postsubs

  has_many :subs,
    through: :postsubs,
    source: :sub


end
