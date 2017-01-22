# frozen_string_literal: true
class SpecialDay < ApplicationRecord
  validates :name,
            presence: true
  validates :day_type,
            presence: true
  validates :date_text,
            presence: true,
            date: { format: I18n.t(:date_format), allow_blank: true }

  scope :availability, -> {
    where(deleted: CONSTANTS::DISABLE_FLAG)
  }

  def date_text
    Date.strptime(date, I18n.t(:default_date_format)).strftime(I18n.t(:date_format))
  rescue
    nil
  end

  def date_text=(value)
    self.date = Date.strptime(value, I18n.t(:date_format)).strftime(I18n.t(:default_date_format))
  rescue
    self.date = nil
  end

  def day_type
    return CONSTANTS::SPECIAL_DAY_HOLIDAY_TYPE if super.blank?
    super
  end

  def day_type_text
    CONSTANTS::SPECIAL_DAY_TYPES[day_type]
  end

  def soft_delete
    update(deleted: CONSTANTS::ENABLE_FLAG)
  end
end
