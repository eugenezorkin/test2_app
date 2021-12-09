class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable;
  has_many :news;
  has_many :assignments
  has_many :roles, :through => :assignments
  enum role: [ :martial, :editor, :admin  ]
  attr_accessor :name
  before_save { self.email = email.downcase }, :default_values
  validates :name, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  
  
  
  
  ROLES = %w[admin editor martial]
  
  def role1?(role)
    roles.include? role.to_s
  end
  
  
  def role?
    
    @is_id = self.id == 1;
    return @is_id;
  end
  
  
  def editor?
    
    return false;
  end
  
  def default_values
    #self.role ||= :martial;
    self.role = :martial if self.role.nil?
  end
  
end
