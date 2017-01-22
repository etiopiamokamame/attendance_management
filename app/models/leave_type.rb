# frozen_string_literal: true
class LeaveType < ApplicationRecord
  validates :content,
            presence: true
  validates :status,
            presence: true

  before_save :set_display_order,
              if: :new_record?

  scope :availability, -> {
    where(deleted: CONSTANTS::ACTIVE_FLAG)
  }

  scope :order_display, -> {
    availability
      .order(:display_order)
  }

  scope :position, ->(position) {
    order_display[position.to_i]
  }

  def change_order(position)
    pl = LeaveType.position(position)
    self.display_order, pl.display_order = pl.display_order, display_order
    save
    pl.save
  end

  def status_name
    CONSTANTS::LEAVE_TYPE_STATUSES[status]
  end

  def enable?
    status == CONSTANTS::LEAVE_TYPE_ENABLE
  end

  def disable?
    status == CONSTANTS::LEAVE_TYPE_DISABLE
  end

  def aggregate_display_enable?
    aggregate_display == CONSTANTS::ACTIVE_FLAG
  end

  def aggregate_display_disable?
    aggregate_display == CONSTANTS::DELETED_FLAG
  end

  private

  def set_display_order
    self.display_order = LeaveType.availability.maximum(:display_order).try(:next) || 1
  end
end
