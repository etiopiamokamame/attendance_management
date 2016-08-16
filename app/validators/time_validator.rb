class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value =~ /\A\d{2}:\d{2}\z/ && Time.strptime(value, "%H:%M")
      true
    else
      record.errors.add(attribute, :invalid)
    end
  rescue ArgumentError
    record.errors.add(attribute, :invalid)
  end
end
