class Holiday < ActiveRecord::Base
  def date
    "#{year}年#{month}月#{day}日"
  end
end
