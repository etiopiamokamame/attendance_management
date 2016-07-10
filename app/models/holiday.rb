class Holiday < ActiveRecord::Base
  validates :name,
    presence: true
  validate :validate_date

  def date
    return nil if year.blank? || month.blank? || day.blank?
    "#{year}年#{month}月#{day}日"
  end

  def date=(value)
    holiday_date = Date.strptime(value, "%Y年%m月%d日")
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
