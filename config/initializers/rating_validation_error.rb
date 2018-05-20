class RatingValidationError < StandardError
  VALUE = 'Value must be between 1 and 5'.freeze
  POST_ID = 'Post id must be present'.freeze
end
