class Article < ApplicationRecord

  # 有効データ
  scope :availability, -> {
    today = Date.today
    where(
      <<-EOF
        posted_start_year <= #{today.year} AND
        posted_start_month <= #{today.month} AND
        posted_start_day <= #{today.day} AND
        posted_end_year >= #{today.year} AND
        posted_end_month >= #{today.month} AND
        posted_end_day >= #{today.day}
      EOF
    ).where(deleted: "0")
  }

  # 新着順
  scope :order_new, -> {
    order("updated_at DESC")
  }

  validates :title,
    presence: true
  validates :body,
    presence: true
  validates :posted_start_date,
    presence: true
  validates :posted_end_date,
    presence: true
  validate :validate_posted_date

  def posted_start_date
    return nil if posted_start_year.blank? || posted_start_month.blank? || posted_start_day.blank?
    "%04d年%02d月%02d日" % [posted_start_year, posted_start_month, posted_start_day]
  end

  def posted_start_date=(value)
    date = Date.strptime(value, I18n.t(:date_format))
    self.posted_start_year  = date.year
    self.posted_start_month = date.month
    self.posted_start_day   = date.day
  rescue
    self.posted_start_year  = nil
    self.posted_start_month = nil
    self.posted_start_day   = nil
  end

  def posted_end_date
    return nil if posted_end_year.blank? || posted_end_month.blank? || posted_end_day.blank?
    "%04d年%02d月%02d日" % [posted_end_year, posted_end_month, posted_end_day]
  end

  def posted_end_date=(value)
    date = Date.strptime(value, I18n.t(:date_format))
    self.posted_end_year  = date.year
    self.posted_end_month = date.month
    self.posted_end_day   = date.day
  rescue
    self.posted_end_year  = nil
    self.posted_end_month = nil
    self.posted_end_day   = nil
  end

  private

  def validate_posted_date
    return if posted_start_date.blank? || posted_end_date.blank?
    if !Date.valid_date?(posted_start_year, posted_start_month, posted_start_day)
      errors.add(:posted_start_date, :invalid)
    elsif !Date.valid_date?(posted_end_year, posted_end_month, posted_end_day)
      errors.add(:posted_end_date, :invalid)
    else
      return if posted_start_date <= posted_end_date
      errors.add(:base, :invalid_consistency_date)
    end
  end
end
