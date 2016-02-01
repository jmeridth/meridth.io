require 'sinatra'
require 'tilt/erb'
require 'pony'

get '/' do
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
