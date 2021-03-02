class Article < ApplicationRecord
  enum category: [:experience, :story]
end