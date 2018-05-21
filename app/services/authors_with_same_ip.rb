class AuthorsWithSameIp
  def call
    same_ip_authors
      .group_by { |r| r[0] }
      .map { |k, v| { k => v.map { |s| s[1] } } }
  end

  private

  def same_ip_authors
    sql = <<-SQL
      SELECT p.author_ip, p.user_login
      FROM posts as p
      WHERE p.author_ip IN
        (SELECT posts.author_ip
         FROM posts
         GROUP BY author_ip
         HAVING COUNT(DISTINCT posts.id) > 1)
    SQL
    ActiveRecord::Base.connection.execute(sql).values
  end
end
