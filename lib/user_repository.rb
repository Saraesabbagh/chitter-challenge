require_relative './user'

class UserRepository
  def all
    query = "SELECT * FROM users;"
    result_set = DatabaseConnection.exec_params(query, [])
    users = []

    result_set.each do |record|
      users << record_to_user(record)
    end
    users
  end

  def find(id)
    query = "SELECT * FROM users WHERE id = $1;"
    params = [id]

    result_set = DatabaseConnection.exec_params(query, params)
    record = result_set[0]

    record_to_user(record)
  end

  def create(user)
    query = "INSERT INTO users (name, username, email, password) VALUES ($1, $2, $3, $4);"
    params = [user.name, user.username, user.email, user.password]

    DatabaseConnection.exec_params(query, params)
  end

  private
  def record_to_user(record)
    user = User.new
    user.id = record["id"].to_i
    user.name = record["name"]
    user.username = record["username"]
    user.email = record["email"]
    user.password = record["password"]
    user
  end
end
