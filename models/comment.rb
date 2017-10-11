ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
class Comment < ActiveRecord::Base
    belongs_to :user
    belongs_to :post
end
