class PostSerializer < ActiveModel::Serializer
  attributes :title, :content, :author_ip
end
