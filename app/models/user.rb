class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable;
  has_many :news;
  
  
  
  
  def role?
    
    @is_id = self.id == 1;
    return @is_id;
  end
  
  
  def editor?
    
    return false;
  end
  
end
