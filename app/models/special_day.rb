# frozen_string_literal: true
class SpecialDay < ApplicationRecord
  # 有効データ
  scope :availability, -> {
    where(deleted: "0")
  }

  scope :holodays, -> {
    availability
      .where(day_type: CONSTANTS::SPECIAL_DAY_HOLIDAY_TYPE)
  }

  scope :business_days, -> {
    availability
      .where(day_type: CONSTANTS::SPECIAL_DAY_BUSINESS_DAY_TYPE)
  }

  validates :name,
            presence: true
  validates :day_type,
            presence: true
  validates :date_text,
            presence: true,
            date: { format: I18n.t(:date_format), allow_blank: true }

  def date
    Date.strptime(date_ymd, I18n.t(:default_date_format, separate: nil))
  rescue
    nil
  end

  def date_text
    return @date_text unless @date_text.blank?
    date.strftime(I18n.t(:date_format))
  rescue
    nil
  end

  def date_text=(value)
    date_value = Date.strptime(value, I18n.t(:date_format))
    self.date_ymd = date_value.strftime(I18n.t(:default_date_format, separate: nil))
  rescue
    self.date_ymd = nil
  ensure
    @date_text = value
  end

  def day_type
    return CONSTANTS::SPECIAL_DAY_HOLIDAY_TYPE if super.blank?
    super
  end

  def day_type_text
    CONSTANTS::SPECIAL_DAY_TYPES[day_type]
  end

  def soft_delete
    update(deleted: "1")
  end
end
