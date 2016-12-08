# frozen_string_literal: true
class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if options[:allow_blank] && value.blank?
      record.errors.add(attribute, :blank)
    else
      return if value.blank?
      Date.strptime(value, options[:format] || "%Y%m%d")
    end
  rescue
    record.errors.add(attribute, :invalid)
  end
end
