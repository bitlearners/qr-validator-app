class QrCode

  attr_reader :scanned_at, :scanned_by, :sr_no, :status, :valid_status

  def initialize(qr_data)
    puts qr_data
    @status = qr_data["status"]
    @scanned_at = qr_data["scanned-at"]
    @scanned_by = qr_data["scanned-by"]
    @sr_no = qr_data["sr-no"]
    #@valid_status = 
  end


end
