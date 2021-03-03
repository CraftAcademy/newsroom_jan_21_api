class Article < ApplicationRecord
  enum article_type: [:experience, :story]
  serialize :created_at, Time
end