class AuthorsWithSameIp
  def call
    same_ip_authors
      .group_by { |r| r[0] }
      .map { |k, v| { k => v.map { |s| s[1] } } }
  end

  private

  def same_ip_authors
    sql = <<-SQL
      SELECT posts.author_ip,
        users.login
      FROM posts
        JOIN users
        ON (posts.user_id = users.id)
      WHERE posts.author_ip IN
        (SELECT posts.author_ip
         FROM users
           JOIN posts
           ON (posts.user_id = users.id)
         GROUP BY author_ip
         HAVING COUNT(distinct users.id) > 1)
    SQL
    ActiveRecord::Base.connection.execute(sql).values
  end
end
