require 'json'

class QrCodesController < ApplicationController

  def index
  end

  def validate
    puts params["data"]
    
  end

end
