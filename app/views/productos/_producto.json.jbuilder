json.extract! producto, :id, :created_at, :updated_at
json.url producto_url(producto, format: :json)
