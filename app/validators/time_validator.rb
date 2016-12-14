# frozen_string_literal: true
class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if options[:allow_blank] && value.blank?
      record.errors.add(attribute, :blank)
    else
      return if value.blank?
      Time.strptime(value, options[:format] || "%H%M")
    end
  rescue
    record.errors.add(attribute, :invalid)
  end
end
