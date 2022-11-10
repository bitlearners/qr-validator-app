class QrCodesBaseController < HomeController
	protect_from_forgery with: :null_session
	before_action :set_user_data, only: %i[signup login]
  before_action :set_task, only: %i[ show edit update destroy ]
  helper_method :update_qr_scan_history, :get_all_qr_history, :get_crnt_usr_qr_history

  attr_reader :ticket_num

  private

  def perform_validation
  	data = fetch_qr_data(ticket_num)            ## fetch from firebase DB
    #binding.pry
    if (data.nil? || data.include?("error"))
      update_qr_scan_history(false, true)       ##  (valid_status, invalid_qr_flag)
      return [false, true] 
      #binding.pry
    elsif data['status']==1
      update_qr_scan_history(false, false, data['sr-no']) 
      return [false, false] 
      #binding.pry
    else
      data["qr_key"] = ticket_num
    	@qr = QrCode.new(Hash(data).with_indifferent_access)
    	#puts data, @qr.as_json
      update_qr_scan_history(true, false, data['sr-no']) 
    	return [true, false]
    end
  end

  def ticket_num
    @ticket_num ||= params["qr_key"]
  end

  def mark_as_arrived
    # update firebse -> qr_value -> "scanned-at"=>"cur_time", "scanned-by"=>"user-name-who-scanned", "status"=>1
    # status  0=not-arrived   1=arrived
    if ticket_num.present?
      data = {
        'status': 1,
        'scanned-at': Time.now().to_s
      }
      puts Time.now().to_s
      puts update_qr_data(ticket_num, data)
    	puts "#{ticket_num} mark_as_arrived"
      return true
    else
    	puts "Error Occured at this point [mark_as_arrived]"
      return false
    end
  end


  def reject_arrive
    # update firebse -> qr_value -> "scanned-at"=>"cur_time", "scanned-by"=>"user-name-who-scanned", "status"=>1
    # status  0=not-arrived   1=arrived
    if ticket_num.present?
      puts "#{ticket_num} rejected arrive"
      return true
    else
      puts "Error Occured at this point [reject_arrive]"
      return false
    end
  end


  # fetch only one QR data from Firebase
  def fetch_qr_data(ticket_num)
    qr_db_path = ENV["firebase_qr_db_root_path"]
    full_path = qr_db_path + "/" + ticket_num
    conn.get(full_path).body 
  end

  def update_qr_data(ticket_num, data, path='')
    qr_db_path = ENV["firebase_qr_db_root_path"]
    full_path = qr_db_path + "/" + ticket_num + "/" + path
    conn.update(full_path, data).body 
  end


  def update_qr_scan_history(scan_status, invalid_qr_flag, scan_value_name='INVALID')     ##  (valid_status, invalid_qr_flag)
    data = get_crnt_usr_qr_history[:data] || []
    #binding.pry
    new_ticket_scan_data = {
      scanned_at: Time.now().to_s,
      scan_value_name: scan_value_name,
      scan_status: scan_status,
      invalid_qr_flag: invalid_qr_flag,
      scan_value: ticket_num,
      scanned_by: user.name
    }
    #binding.pry
    data.append(new_ticket_scan_data)
    qr_db_path = ENV["firebase_scanned_qr_db_root_path"]
    full_path = qr_db_path + "/" + current_user
    puts conn.set(full_path, data).body
  end


  #################################################################################################################

  def get_all_qr_history
    render json: {data: fetch_all_qr_data(userid)}
  end

  def get_crnt_usr_qr_history
    #userid = "kwFNLiyewNVedvqy9LkjihgWopk2" #params[:user_id] if !params.nil? && params[:user_id].present?
    #render json: {data: fetch_crnt_usr_qr_data}
    {data: fetch_crnt_usr_qr_data}
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
    #full_path = qr_db_path + "/" + userid if userid.present?
    full_path = qr_db_path + "/" + current_user 
    full_path = qr_db_path + "/" + userid if userid.present?

    conn.get(full_path).body
  end


end
