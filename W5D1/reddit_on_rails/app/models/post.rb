class Post < ApplicationRecord
  validates :title, :sub, :author, presence: true

  belongs_to :author,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :sub,
    class_name: "Sub",
    primary_key: :id,
    foreign_key: :sub_id

end
