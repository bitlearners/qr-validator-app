class QrCodesBaseController < HomeController
	protect_from_forgery with: :null_session
	before_action :set_user_data, only: %i[signup login]
  before_action :set_task, only: %i[ show edit update destroy ]

  attr_reader :ticket_num

  private

  def perform_validation
  	data = fetch_qr_data(ticket_num)            ## fetch from firebase DB
    #binding.pry
    return [false, true] if (data.nil? || data.include?("error"))
    #binding.pry
    return [false, false] if data['status']==1
    #binding.pry
    data["qr_key"] = ticket_num
  	@qr = QrCode.new(Hash(data).with_indifferent_access)
  	#puts data, @qr.as_json
  	return [true, false]
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
        'scanned-at': Time.now() || "sometime"
      }
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


  # fetch total DB data from Firebase
  def fetch_all_qr_data
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


end
