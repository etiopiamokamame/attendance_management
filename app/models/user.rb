# frozen_string_literal: true
class User < ApplicationRecord
  has_many :articles
  has_many :attendances

  attr_accessor :password_confirm

  # 有効データ
  scope :availability, -> {
    where(deleted: "0")
  }

  def admin?
    admin == "1"
  end

  def fiscal_year_attendances
    today     = Date.today
    from, to  = if CONSTANTS::START_FISCAL_YEAR <= today.month
                  [
                    Date.new(today.year, CONSTANTS::START_FISCAL_YEAR, 1),
                    Date.new(today.next_year.year, CONSTANTS::END_FISCAL_YEAR, 1)
                  ]
                else
                  [
                    Date.new(today.prev_year.year, CONSTANTS::START_FISCAL_YEAR, 1),
                    Date.new(today.year, CONSTANTS::END_FISCAL_YEAR, 1)
                  ]
                end

    period = (from..to).map do |day|
      day if day == day.beginning_of_month
    end.compact

    collection = attendances.fiscal_year.to_a

    period.map do |day|
      collect = collection.find { |c| c.date == day }
      next collect unless collect.blank?
      attendace = attendances.new
      attendace.date_text = day.strftime(I18n.t(:date_format_ym))
      attendace
    end
  end
end
