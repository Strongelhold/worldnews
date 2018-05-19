class PostValidationError < StandardError
  TITLE = "Post's title can't be blank".freeze
  CONTENT = "Post's content can't be blank".freeze
  LOGIN = "User's login can't be blank".freeze
  AUTHOR_IP = "Author's ip can't be blank".freeze
end
