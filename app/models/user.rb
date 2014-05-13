class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save :set_default_role

  ROLES = %w[employee admin]

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def is_admin?
    role == 'admin'
  end

  def set_default_role
    if self.new_record?
      self.role = 'employee'
    end
  end

end
