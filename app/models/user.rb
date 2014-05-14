class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email,
            :presence => true,
            :length => { :in => 6..100 },
            :uniqueness => true,
            :format => { :with => /[-a-z0-9_+\.]+\@(cuberoot\.in)/i, :message => "should be a cuberoot.in email" }

  before_save :set_default_role

  self.per_page = 10

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
