class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable;
  has_many :news;
  #enum role: [ :martial, :editor, :admin  ]
  #attr_accessor :name
  before_save { self.email = email.downcase } # :default_values
  validates :name, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  #validates :role #, inclusion: { in: role }
  #validates_inclusion_of :role, in: roles.keys
  
  #def default_values
    #self.role ||= :martial;
   #self.role = :martial if self.role.nil?
  #end
  
  

  #def role=(value)
  #  super
  #rescue ArgumentError
  #  @attributes.write_cast_value("role", :martial)
  #end
  
end
