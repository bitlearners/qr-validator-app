class QrCodesController < QrCodesBaseController
  
  # {"08dd1001c0ed942c168c55ca638e9ba3"=>{"scanned-at"=>"03-Nov-22 5:07pm", "scanned-by"=>"user1", "sr-no"=>1, "status"=>0}}

  def index
    #@valid_status = "nil"
    #render(partial: "scan_status", locals: @valid_status )
  end

  def scanner
    @valid_status = "nil"
  end

  def profile

  end

  def history; end

  def settings; end

  def qr_approve_ticket
    puts @valid_status
  end

  def qr_reject_ticket
    puts @valid_status
  end




#  def scan_status
#    respond_to do |format|
#      format.js {render layout: false}
#      format.html { render 'scan_status', json: {scheduled_task_id: "scheduled_task.id"}} # I had to tell rails to use the index by default if it's a html request. 
#    end
#  end

  def validate
    #puts params["data"]
    #puts conn.get("").body

    valid = perform_validation
    @valid_status = valid

    render json: {data: @valid_status} 
    return mark_as_arrived if valid
    puts "Invalid Ticket QR" if !valid

  end


  def fetch_data
    data = {
      name: "Noman",
      age: "xx"
    }
    render json: {data: data} 
  end

end
