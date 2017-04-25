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

  has_many :comments, dependent: :destroy

  def comments_by_parent_id
    @parent_comments = Hash.new {|h,k| h[k] = [] }
    self.comments.includes(:author).each do |comment|
      @parent_comments[comment.parent_comment_id] << comment
    end
    @parent_comments
  end

end
