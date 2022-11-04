class QrCodesBaseController < HomeController
	protect_from_forgery with: :null_session
	before_action :set_user_data, only: %i[signup login]
  before_action :set_task, only: %i[ show edit update destroy ]

  def conn
    @conn ||= App.task_reminder_firebase.conn
  end

  def load_tasks
    @tasks ||= conn.get("task/").body.compact
    #binding.pry
  end

  attr_reader :ticket_num

  private

  def perform_validation
  	@ticket_num = params["data"]
  	data = conn.get(ticket_num).body
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
  def fetch_all_data
  end

  # fetch only one QR data from Firebase
  def fetch_data
  end

end
