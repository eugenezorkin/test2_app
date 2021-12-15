class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable;
  has_many :news;

  enum digest: [ :nodigest, :weekly, :dayly  ]
  before_save { self.email = email.downcase } # :default_values
  before_create :default_values
  validates :name, presence: true, length: { maximum: 255 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  
  def default_values
    self.digest ||= :weekly;
    self.digest = :weekly if self.digest.nil?
  end
  
  
end
