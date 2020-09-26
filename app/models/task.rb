class Task < ApplicationRecord
  validates :name,  presence: true, length: { maximum: 30 }
  validates :content,  presence: true, length: { maximum: 144 }

  scope :name_search, ->(name){ where("name LIKE ?", "%#{name}%") }
  scope :status_search, ->(status){ where(status: status) }
end
