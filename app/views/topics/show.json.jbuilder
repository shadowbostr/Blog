json.partial! "topics/topic", topic: @topic

json.posts @topic.posts , :id, :title, :created_at, :updated_at
