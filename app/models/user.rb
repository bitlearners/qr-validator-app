class User

  attr_reader :name, :id, :qr_scan_count, :cam_pref, :email

  def conn
    @conn ||= App.firebase.conn
  end

  def initialize(user_data)
    puts user_data
    @name = user_data[:name]
    @email = user_data[:email]
    @id = user_data[:id]
    @qr_scan_count = user_data[:qr_scan_count]
    @cam_pref = user_data[:cam_pref]
  end

  def as_rdb
  	{
			cam_pref: cam_pref,
			name: name,
			qr_scan_count: qr_scan_count
		}
  end

  def update_db
    #binding.pry
    return unless id
    user_db_path = ENV["firebase_user_db_root_path"]
    path = user_db_path + "/" + id
    #binding.pry
    data = conn.set(path, as_rdb).body
    #binding.pry
    return nil if (data.nil? || data.include?("error") )
  end

end