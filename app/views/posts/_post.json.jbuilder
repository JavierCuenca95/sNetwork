json.extract! post, :id, :nombre, :contenido, :created_at, :updated_at
json.url post_url(post, format: :json)
