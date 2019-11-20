json.extract! issue, :id, :Title, :Description, :Type, :Priority, :Status, :assignee_id, :user_id, :Votes, :attachment_file_name, :attachment_content_type, :attachment_file_size, :attachment_update_at, :created_at, :updated_at
json.url issue_url(issue, format: :json)
