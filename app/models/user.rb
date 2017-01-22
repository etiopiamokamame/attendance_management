# frozen_string_literal: true
class User < ApplicationRecord
  has_many :articles

  attr_accessor :password_confirm

  # 有効データ
  scope :availability, -> {
    where(deleted: CONSTANTS::DISABLE_FLAG)
  }

  def admin?
    admin == "1"
  end
end
