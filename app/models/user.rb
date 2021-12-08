class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable;
  has_many :news;
  has_many :assignments
  has_many :roles, :through => :assignments
  
  
  
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
  
end
