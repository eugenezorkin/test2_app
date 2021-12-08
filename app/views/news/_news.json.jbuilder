json.extract! news, :id, :title, :content, :author, :user_id, :created_at, :updated_at
json.url news_url(news, format: :json)
