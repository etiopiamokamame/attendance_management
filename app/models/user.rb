class User < ApplicationRecord
  default_scope ->{ where(deleted: false) }

  has_many :attendances
  has_many :working_reports

  attr_accessor :password_confirm

  validates :name,
    presence: true
  validates :affiliation_name,
    presence: true
  validates :number,
    presence: true,
    uniqueness: true
  validates :password,
    presence: true
  validate :validate_password,
    on: :create

  def init_password
    self.update(password: self.number)
  end

  def remove
    self.update(deleted: true)
    self.attendances.update_all(deleted: true)
    self.working_reports.update_all(deleted: true)
  end

  def this_month_attendance
    today = Date.today
    self.attendances.find_or_initialize_by(year: today.year, month: today.month)
  end

  class << self
    def change_admin(params)
      return if params.blank?
      admin_ids     = params.map { |opt| opt[:id] if opt[:admin] == "true" }.compact
      not_admin_ids = params.map { |opt| opt[:id] } - admin_ids
      User.where(id: admin_ids).update_all(admin: true)
      User.where(id: not_admin_ids).update_all(admin: false)
    end
  end

  private

  def validate_password
    return if self.password == self.password_confirm
    self.errors.add(:password, :confirmation)
  end
end
