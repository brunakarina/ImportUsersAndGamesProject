class UploadController < ApplicationController

  def index
    
  end


  def create


    filename = "#{Time.now.to_i}_#{params[:file].original_filename}"
    file_path = Rails.root.join('tmp', filename)
    File.open(file_path, 'wb') do |f|
      f.write(params[:file].read)
    end
   
    ImportUsersJob.perform_later(file_path.to_s)

    redirect_to upload_index_path
  end
end
