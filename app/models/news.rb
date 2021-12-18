class News < ApplicationRecord
  belongs_to :user
  before_save :count_edits
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validate :check_edits_number
  
  def check_edits_number
    if((not self.edits_number.nil?) && self.edits_number>=5)
      errors.add(:base, "Изменения не сохранены, Вы превысили лимит 5 редактирований новости!")
    end;
  end;
  
  def count_edits
    if !self.edits_number || self.edits_number.nil?
      self.edits_number = 0;
    else
      self.edits_number += 1;
    end;
  end;
  
  
  def can_edit?
    return self.edits_number<5
  end;
  #load_and_authorize_resource

  # comments_controller.rb possibility
  #load_and_authorize_resource :nested => :article
  
  
  
end
