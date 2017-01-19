# frozen_string_literal: true
module Util
  module DateUtil
    class << self
      def valid?(val, format = I18n.t(:default_date_format, separate: nil))
        return false if val.blank?
        Date.strptime(val, format)
        reg = format.gsub(/%Y/, "[0-9]{4}")
                    .gsub(/%m/, "[0-9]{2}")
                    .gsub(/%d/, "[0-9]{2}")

        !(/\A#{reg}\z/ =~ val).nil?
      rescue
        false
      end
    end
  end
end
