# frozen_string_literal: true
class Reason < ApplicationRecord
  validates :content,
            presence: true

  before_save :set_display_order,
              if: :new_record?
  after_save :prepare_display_orders,
             if: :deleted?

  scope :availability, -> {
    where(deleted: CONSTANTS::DISABLE_FLAG)
  }

  scope :order_display, -> {
    availability
      .order(:display_order)
  }

  scope :position, ->(position) {
    order_display[position.to_i]
  }

  def change_order(position)
    pr = Reason.position(position)
    self.display_order, pr.display_order = pr.display_order, display_order
    save
    pr.save
  end

  def soft_delete
    update(deleted: CONSTANTS::ENABLE_FLAG)
  end

  def deleted?
    deleted == CONSTANTS::ENABLE_FLAG
  end

  private

  def set_display_order
    self.display_order = Reason.availability.maximum(:display_order).try(:next) || 1
  end

  def prepare_display_orders
    reasons = Reason.availability.where("display_order > ?", display_order)
    reasons.each do |reason|
      reason.decrement(:display_order)
      reason.save
    end
  end
end
