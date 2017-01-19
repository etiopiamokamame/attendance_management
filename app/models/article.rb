# frozen_string_literal: true
class Article < ApplicationRecord
  belongs_to :user

  # 有効データ
  scope :availability, -> {
    where(deleted: "0")
  }

  # 掲載期間中データ
  scope :posted_period, -> {
    today = Date.today.strftime(I18n.t(:default_date_format, separate: nil))
    table = arel_table
    query = table[:posted_start_date_ymd].lteq(today)
    query = query.and(table[:posted_end_date_ymd].gteq(today))
    availability.where(query)
  }

  # 新着順
  scope :order_new, -> {
    order(updated_at: :desc)
  }

  validates :title,
            presence: true
  validates :body,
            presence: true
  validates :posted_start_date_text,
            presence: true,
            date: { format: I18n.t(:date_format), allow_blank: true }
  validates :posted_end_date_text,
            presence: true,
            date: { format: I18n.t(:date_format), allow_blank: true }
  validate :validate_posted_period

  def posted_start_date
    Date.strptime(posted_start_date_ymd, I18n.t(:default_date_format, separate: nil))
  rescue
    nil
  end

  def posted_start_date_text
    return @posted_start_date_text unless @posted_start_date_text.blank?
    posted_start_date.strftime(I18n.t(:date_format))
  rescue
    nil
  end

  def posted_start_date_text=(value)
    date_value = Date.strptime(value, I18n.t(:date_format))
    self.posted_start_date_ymd = date_value.strftime(I18n.t(:default_date_format, separate: nil))
  rescue
    self.posted_start_date_ymd = nil
  ensure
    @posted_start_date_text = value
  end

  def posted_end_date
    Date.strptime(posted_end_date_ymd, I18n.t(:default_date_format, separate: nil))
  rescue
    nil
  end

  def posted_end_date_text
    return @posted_end_date_text unless @posted_end_date_text.blank?
    posted_end_date.strftime(I18n.t(:date_format))
  rescue
    nil
  end

  def posted_end_date_text=(value)
    date = Date.strptime(value, I18n.t(:date_format))
    self.posted_end_date_ymd = date.strftime(I18n.t(:default_date_format, separate: nil))
  rescue
    self.posted_end_date_ymd = nil
  ensure
    @posted_end_date_text = value
  end

  def created_at_text
    return if created_at.blank?
    created_at.strftime(I18n.t(:date_format))
  end

  def soft_delete
    update(deleted: "1")
  end

  private

  def validate_posted_period
    return if errors.messages[:posted_start_date_text].present? || errors.messages[:posted_end_date_text].present?
    return if posted_start_date_text.blank? || posted_end_date_text.blank?
    return if posted_start_date_text <= posted_end_date_text
    errors.add(:posted_start_date, :after_end_date)
    errors.add(:posted_end_date, :before_start_date)
  end
end
