class QrCodesController < QrCodesBaseController
  # {"08dd1001c0ed942c168c55ca638e9ba3"=>{"scanned-at"=>"03-Nov-22 5:07pm", "scanned-by"=>"user1", "sr-no"=>1, "status"=>0}}

  def index
    @valid_status = "nil"
    #render(partial: "scan_status", locals: @valid_status )
  end

  def test; end

  def validate
    #puts params["data"]
    #puts conn.get("").body

    valid = perform_validation
    @valid_status = valid
    #render partial: "scan_status", locals: @valid_status 
    respond_to do |format|
      format.js {render layout: false}
      format.html { render 'scan_status'} # I had to tell rails to use the index by default if it's a html request. 
    end
    return mark_as_arrived if valid
    puts "Invalid Ticket QR" if !valid

  end

end
