PDFKit.configure do |config|

   config.default_options = {
     :page_size => 'A4',
     :print_media_type => true,
     :margin_top => '0',
     :margin_right => '0',
     :margin_left => '0',
     :margin_bottom => '0',

   }
  # config.root_url = "http://localhost" # Use only if your external hostname is unavailable on the server.
end

ActionController::Base.asset_host = Proc.new { |source, request|
  if request.format.pdf?
    "#{request.protocol}#{request.host_with_port}"
  else
    nil
  end
}
