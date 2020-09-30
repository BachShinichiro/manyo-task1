class Task < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :content,  presence: true, length: { maximum: 144 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
  belongs_to :user

  scope :name_search, ->(name){ where("name LIKE ?", "%#{name}%") }
  scope :status_search, ->(status){ where(status: status) }
end
