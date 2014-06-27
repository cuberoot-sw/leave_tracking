class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            :presence => true,
            :length => { :in => 6..100 },
            :uniqueness => true,
            :format => { :with => /[-a-z0-9_+\.]+\@(cuberoot\.in)/i, :message => "should be a cuberoot.in email" }

  before_save :set_default_role unless Rails.env.test? # disable default_role

  has_many :leaves, :class_name => 'Leave'

  self.per_page = 10

  mount_uploader :profile_pic, ProfilePicUploader

  scope :approved_by, lambda{ |id|
    where(id: id).first.name
  }

  scope :manager, lambda {
    where(id: self.manager_id).first
  }

  scope :birthdays, lambda {
    where("extract(month from date_of_birth) = ? AND
           extract(day from date_of_birth) = ?",
           Time.now.month, Time.now.day)
  }

  ROLES = %w[employee admin]

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def is_admin?
    role == 'admin'
  end

  def is_manager?
    role == 'manager'
  end

  def is_employee?
    role == 'employee'
  end

  def set_default_role
    if self.new_record?
      self.role = 'employee'
    end
  end

  def manager
    User.where(id: self.manager_id).first
  end

  def resources
    User.where(manager_id: self.id)
  end

  def collect_leaves_count
    total_leaves = Leave.calculate_total_leaves(self)
    balance_leaves = Leave.balance_leaves(self)
    return total_leaves, balance_leaves
  end

end
