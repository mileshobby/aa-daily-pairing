# == Schema Information
#
# Table name: subs
#
#  id          :integer          not null, primary key
#  title       :string           not null
#  description :text             not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
    class_name: "User",
    primary_key: :id,
    foreign_key: :user_id

  has_many :postsubs
  
  has_many :posts,
    through: :postsubs,
    source: :post


end
