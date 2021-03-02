class Article < ApplicationRecord
  enum category: [:experience, :story]
  serialize :created_at, Time
end