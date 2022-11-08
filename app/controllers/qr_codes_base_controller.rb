class QrCodesBaseController < HomeController
	protect_from_forgery with: :null_session
	before_action :set_user_data, only: %i[signup login]
  before_action :set_task, only: %i[ show edit update destroy ]

  attr_reader :ticket_num

  private

  def perform_validation
  	@ticket_num = params["data"]
  	data = fetch_qr_data(ticket_num)            ## fetch from firebase DB
  	@qr = QrCode.new(Hash(data).with_indifferent_access)
  	puts data
  	return true unless (data.nil? || data.include?("error") )
  	false
  end

  
  def mark_as_arrived
    # update firebse -> qr_value -> "scanned-at"=>"cur_time", "scanned-by"=>"user-name-who-scanned", "status"=>1
    # status  0=not-arrived   1=arrived
    if ticket_num.present?
    	puts "#{ticket_num} mark_as_arrived"
    else
    	puts "Error Occured at this point"
    end
  end

  # fetch total DB data from Firebase
  def fetch_all_qr_data
  end

  # fetch only one QR data from Firebase
  def fetch_qr_data(ticket_num)
    qr_db_path = ENV["firebase_qr_db_root_path"]
    path = qr_db_path + "/" + ticket_num
    conn.get(path).body 
  end



end
