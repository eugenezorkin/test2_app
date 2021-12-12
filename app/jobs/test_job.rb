class TestJob < ApplicationJob
  #queue_as :new1
  @queue = :new1

  
end
