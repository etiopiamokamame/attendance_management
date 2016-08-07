class Holiday < ApplicationRecord
  validates :name,
    presence: true
  validate :validate_date

  def date
    return nil if year.blank? || month.blank? || day.blank?
    "%04d年%02d月%02d日" % [year, month, day]
  end

  def date=(value)
    holiday_date = Date.strptime(value, I18n.t(:date_format))
    self.year    = holiday_date.year
    self.month   = holiday_date.month
    self.day     = holiday_date.day
  rescue
    self.year    = nil
    self.month   = nil
    self.day     = nil
  end

  private

  def validate_date
    if year.blank?
     errors.add(:date, :blank)
     return
   end
    if month.blank?
     errors.add(:date, :blank)
     return
   end
    if day.blank?
     errors.add(:date, :blank)
     return
   end

    return if Date.valid_date?(year, month, day)
    errors.add(:date, :invalid)
  end
end
