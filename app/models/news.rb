class News < ApplicationRecord
  belongs_to :user
  load_and_authorize_resource

  # comments_controller.rb possibility
  load_and_authorize_resource :nested => :article
  
end
