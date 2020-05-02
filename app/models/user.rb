# frozen_string_literal: true

class User < ApplicationRecord
  before_destroy :destroy_action
  before_update :update_action

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  has_many :tasks, dependent: :destroy

  private

  def destroy_action
    if User.where(admin: true).count == 1
      user = User.where(admin: true)
      throw :abort if user[0] == self
    end
  end

  def update_action
    if User.where(admin: true).count == 1 && admin == false
      user = User.where(admin: true)
      if user[0] == self
        errors.add(:user, '更新にエラーがあります。現在あなたのみが管理人のため管理人から外れることはできません。')
        throw :abort
      end
    end
  end
end
