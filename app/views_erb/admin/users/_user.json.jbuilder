json.extract! user, :id, :email, :name, :admin, :editor, :created_at, :updated_at
json.url user_url(user, format: :json)
