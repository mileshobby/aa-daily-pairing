class Comment < ApplicationRecord
  validates :post, :author, :content, presence: true

  belongs_to :post

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :child_comments,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id,
    dependent: :destroy

  belongs_to :parent_comment,
    class_name: "Comment",
    foreign_key: :parent_comment_id,
    primary_key: :id,
    optional: true

end
