require 'dotenv'
require 'sinatra'
require 'tilt/erb'
require 'pony'
require 'httparty'

Dotenv.load

get '/' do
  @years_experience = (Time.now.year - 2000)
  @recaptcha_sitekey = ENV['RECAPTCHA_SITEKEY']
  erb :index
end

post '/contact' do
  if !params[:name] ||
     !params[:email] ||
     !params[:phone] ||
     !params[:message] ||
     !valid_email?(params[:email])
    return false
  end

  headers = { 'Content-Type' => 'application/json',
              'Accept' => 'application/json' }
  query = { secret: ENV['RECAPTCHA_SECRET_KEY'],
            response: params[:captchaResponse] }
  response = HTTParty.post('https://www.google.com/recaptcha/api/siteverify',
                           query: query,
                           headers: headers,
                           verify: false)
  unless response['success']
    content_type :json
    error 401, 'ReCaptcha not completed.  Please complete to prove you are human'
  end

  Pony.mail to: 'contact@meridth.io',
            from: 'noreply@meridth.io',
            subject: 'Meridth, LLC Website Contact Form',
            body: erb(:contact_email, layout: false)
end

not_found do
  erb :error
end

error do
  erb :error
end

helpers do
  def valid_email?(email)
    email =~ /^([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})$/i
  end
end
