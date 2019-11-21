class Comment < ApplicationRecord
  belongs_to :issue
  belongs_to :user

  
  default_scope { order(created_at: :asc) }
end
