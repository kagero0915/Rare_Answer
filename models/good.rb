ActiveRecord::Base.establish_connection("sqlite3:db/development.db")
class Good < ActiveRecord::Base
    belongs_to :post
end