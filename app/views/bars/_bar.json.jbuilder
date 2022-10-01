# frozen_string_literal: true

json.extract! bar, :id, :name, :created_at, :updated_at
json.url bar_url(bar, format: :json)
