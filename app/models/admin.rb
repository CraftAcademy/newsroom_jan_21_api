# frozen_string_literal: true

class Admin < ActiveRecord::Base
  extend Devise::Models
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User
  has_many :articles
  enum role: [:admin, :editor, :journalist]
end
