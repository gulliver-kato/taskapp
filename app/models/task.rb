class Task < ApplicationRecord
    validates :name,  presence: true
    validates :content,  presence: true

    enum priority: { 高: 1, 中: 2, 低: 3 }
    enum status: { 完了: 1, 着手中: 2, 未着手: 3 }
end
