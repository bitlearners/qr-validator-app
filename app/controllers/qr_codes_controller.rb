class QrCodesController < QrCodesBaseController
  
  # {"08dd1001c0ed942c168c55ca638e9ba3"=>{"scanned-at"=>"03-Nov-22 5:07pm", "scanned-by"=>"user1", "sr-no"=>1, "status"=>0}}

  def index
    #@valid_status = "nil"
    #render(partial: "scan_status", locals: @valid_status )
  end

  def scanner
    @valid_status = "nil"
    @invalid_qr_flag = "nil"
  end

  def profile
  end

  def history
    @user_history ||= get_crnt_usr_qr_history.with_indifferent_access
    @history_count = @user_history["data"].count
    puts @user_history
  end

  def history_data
    render json: {data: fetch_crnt_usr_qr_data}
  end

  def settings; end

  def qr_approve_ticket
    #puts params
    resp = mark_as_arrived
    render json: {status: resp}
  end

  def qr_reject_ticket
    resp = reject_arrive
    render json: {status: resp}
  end


  def validate
    puts params
    #puts conn.get("").body

    valid, invalid_qr_flag = perform_validation
    @valid_status = valid
    @invalid_qr_flag = invalid_qr_flag
    puts data: {valid_status: @valid_status, invalid_qr_flag: @invalid_qr_flag} 
    render json: {data: {valid_status: @valid_status, invalid_qr_flag: @invalid_qr_flag} } 
    #return mark_as_arrived if valid
    puts "Invalid Ticket QR" if !valid
    [valid, invalid_qr_flag]
  end


  def fetch_data
    data = {
      name: "Noman",
      age: "xx"
    }
    render json: {data: data} 
  end

end
