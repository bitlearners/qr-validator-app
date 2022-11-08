class QrCode

  attr_reader :scanned_at, :scanned_by, :sr_no, :status, :qr_key

  def initialize(qr_data)
    puts qr_data
    @status = qr_data["status"]
    @scanned_at = qr_data["scanned-at"]
    @scanned_by = qr_data["scanned-by"]
    @sr_no = qr_data["sr-no"]
    @qr_key = qr_data["qr_key"] 
  end

  def as_json
    {
      status: status,
      scanned_at: scanned_at,
      scanned_by: scanned_by,
      sr_no: sr_no,
      qr_key: qr_key 
    }.compact
  end

end
