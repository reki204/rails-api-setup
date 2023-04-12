# frozen_string_literal: true

class Post < ApplicationRecord
  # must
  validates :title, presence: true
  validates :content, presence: true
end
