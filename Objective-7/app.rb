# encoding: ASCII-8BIT

SECRET_KEY = 'mybigsigningkey!'
FIRMWARE_FILE = '/var/firmware.zip'

require 'rubygems'

require 'base64'
require 'json'
require 'sinatra'
require 'sinatra/base'
require 'singlogger'
require 'securerandom'
require 'timeout'

require 'zip'
require 'cgi'

require 'digest/sha1'

LOGGER = ::SingLogger.instance()

MAX_SIZE = 1024**2 # 1mb

# Manually escaping is annoying, but Sinatra is lightweight and doesn't have
# stuff like this built in :(
def h(html)
  CGI.escapeHTML html
end

def handle_zip(data)
  # Write the data to a zipfile
  begin
    file = Tempfile.new()
    file.write(data)
    file.close()

    executable = "#{ file.path }-out/firmware.bin"
    zip_cmd = "unzip '#{ file.path }' 'firmware.bin' -d '#{ file.path }-out' 2>&1"

    zip_output = `#{ zip_cmd }`
    if !File.exists?(executable)
      raise "Could not extract firmware.bin from the archive:\n\n$ #{ zip_cmd } && #{ executable }\n\n#{ zip_output }"
    end

    # Do the actual execution in the background
    Thread.new do
      begin
        Timeout::timeout(30) do
          LOGGER.debug(`#{ executable }`)
        end
      ensure
        File.delete(executable)
      end
    end
  ensure
    file.unlink()
  end
end

def handle_firmware(filename)
  f = File.read(filename)
  if !f
    raise "File upload failed"
  end

  # Parse the JSON
  begin
    data = JSON.parse(f)
  rescue Exception => e
    raise "Failed to parse uploaded file as JSON: #{ e }"
  end

  # Decode the data
  begin
    zip_data = Base64.decode64(data['firmware'])
  rescue Exception => e
    raise "Failed to base64-decode the 'firmware' key from the uploaded file: #{ e }"
  end

  # Make sure they didn't mess with the other parameters
  if data['secret_length'] != SECRET_KEY.length
    raise "Unexpected secret_length value; it must be #{ SECRET_KEY.length }"
  end

  if data['algorithm'] != 'SHA256'
    raise "Unexpected algorithm; it must be SHA256"
  end

  # Validate it
  expected_signature = Digest::SHA2.hexdigest(SECRET_KEY + zip_data)
  if expected_signature != data['signature']
    raise "Failed to verify the signature! Make sure you are signing the data correctly: sha256(<secret> + raw_file_data)"
  end

  # Everything seems good, deal with the rest
  begin
    handle_zip(zip_data)
  rescue Exception => e
    raise "Failed to parse the ZIP file: #{ e }"
  end
end

module Printer
  class Server < Sinatra::Base
    def initialize(*args)
      super(*args)
    end

    configure do
      if(defined?(PARAMS))
        set :port, PARAMS[:port]
        set :bind, PARAMS[:host]
      end

      set :raise_errors, false
      set :show_exceptions, false
    end

    error do
      LOGGER.error("Error: #{ env['sinatra.error'] }")
      return 500, erb(:error, :locals => { message: "Error in #{ __FILE__ }: #{ h(env['sinatra.error'].message) }" })
    end

    not_found do |e|
      LOGGER.error("Not found: #{ e.to_s }")
      return 404, erb(:error, :locals => { message: "Error in #{ __FILE__ }: Route not found: #{ h(e.to_s) }" })
    end

    get '/' do
      erb(:index)
    end

    get '/topbar' do
      erb(:topbar)
    end

    get '/left_bar' do
      erb(:left_bar)
    end

    get '/PrinterStatus' do
      erb(:PrinterStatus)
    end

    get '/langbar' do
      erb(:langbar)
    end

    get '/login' do
      erb(:login)
    end

    post '/login' do
      erb(:error, :locals => { message: "Login is disabled" })
    end

    get '/config' do
      erb(:config)
    end

    get '/reports_and_information' do
      erb(:reports_and_information)
    end

    get '/linksindex' do
      erb(:linksindex)
    end

    get '/firmware/download' do
      headers['Content-Type'] = 'application/json'
      headers['Content-Disposition'] = 'attachment; filename="firmware-export.json"'
      file = File.read(FIRMWARE_FILE)

      return {
        'firmware' => Base64.strict_encode64(file),
        'signature' => Digest::SHA2.hexdigest(SECRET_KEY + file),
        'secret_length' => SECRET_KEY.length,
        'algorithm' => 'SHA256',
      }.to_json
    end

    get '/firmware' do
      erb(:firmware, :locals => { message: nil })
    end

    post '/firmware' do
      begin
        puts "Received a firmware update!"

        handle_firmware(params['file']['tempfile'].path)
        erb(:firmware, :locals => { message: "Firmware successfully uploaded and validated! Executing the update package in the background" })
      rescue Exception => e
        puts e
        puts e.backtrace
        erb(:error, :locals => { message: "Firmware update failed:<br/><pre>#{ h(e.to_s) }</pre>" })
      end
    end

    get '/secretendpointforuptime' do
      return File.read('/tmp/uptime-check.txt')
    end
  end
end
