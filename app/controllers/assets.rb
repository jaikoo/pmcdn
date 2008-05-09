class Assets < Application
  
  def show
    file = request.env['REQUEST_PATH'].gsub('/assets/', '')
    obj = AWS::S3::S3Object.find(file, 'moo_test' )
    stream_file({ :filename =>  file, :type => obj.content_type,
      :content_length => obj.content_length }) do |response|
      AWS::S3::S3Object.stream(file, 'moo_test') do |chunk|
        response.write chunk
      end
    end
  rescue Exception => e
    raise NotFound
  end
  
end
