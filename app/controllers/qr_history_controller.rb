class QrHistoryController < HomeController
	protect_from_forgery with: :null_session


  def get_all_qr_history
  	#puts current_user
  	userid = "kwFNLiyewNVedvqy9LkjihgWopk2"
  	render json: {data: fetch_all_qr_data(userid)}
  end

  def get_crnt_usr_qr_history
  	#userid = "kwFNLiyewNVedvqy9LkjihgWopk2" #params[:user_id] if !params.nil? && params[:user_id].present?
  	render json: {data: fetch_crnt_usr_qr_data}
  end

  private

  # fetch total DB data from Firebase
  def fetch_all_qr_data(user_id=nil)
    qr_db_path = ENV["firebase_scanned_qr_db_root_path"]
    full_path = qr_db_path
    full_path += "/" + user_id if user_id.present?

    conn.get(full_path).body
  end

  def fetch_crnt_usr_qr_data(userid=nil)
    qr_db_path = ENV["firebase_scanned_qr_db_root_path"]
    full_path = qr_db_path + "/" + userid if userid.present?
    full_path = qr_db_path + "/" + current_user if userid.nil? && current_user

    conn.get(full_path).body
  end

end
