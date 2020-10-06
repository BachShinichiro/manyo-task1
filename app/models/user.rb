class User < ApplicationRecord
  before_destroy :last_one
  has_many :tasks, dependent: :destroy
  has_secure_password
  before_validation { email.downcase! }
  validates :password, presence: true, length: { minimum: 4 }
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  private
  def last_one
    if self.admin? && User.all.where(admin: "true").count == 1
      # return false　ではなく throw :abort
      throw :abort
    end
  end
end
