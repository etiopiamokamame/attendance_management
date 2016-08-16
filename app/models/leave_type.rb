class LeaveType < ApplicationRecord
  scope :availability, -> {
    where(deleted: "0")
  }
end
