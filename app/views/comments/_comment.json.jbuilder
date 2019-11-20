json.extract! comment, :id, :body, :issue_id, :user_id, :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_update_at, :created_at, :updated_at
json.url comment_url(comment, format: :json)
