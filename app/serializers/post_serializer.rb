class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :content, :author_ip
end
