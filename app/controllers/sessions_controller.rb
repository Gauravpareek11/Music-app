class SessionsController < ApplicationController
    before_action :authorize ,only: [:destroy]
    def new
    end
    def create
        user = User.find_by_email(params[:email])
        # If the user exists AND the password entered is correct.
        if user && user.authenticate(params[:password].downcase)
        # Save the user id inside the browser cookie. This is how we keep the user 
        # logged in when they navigate around our website.
        session[:user_id] = user.id
        redirect_to '/',notice:"Succesfully logged in"
        else
        # If user's login doesn't work, send them back to the login form.
        redirect_to '/login',flash: {error:"Invalid email id or password"}
        end
    end
    def omni_create
        user = User.from_omniauth(request.env['omniauth.auth'])
        session[:user_id] = user.id
    
        # Retrieve Google Contacts
        contacts = request.env['omniauth.auth'][:extra][:raw_info][:contacts]
        # Do something with the contacts data, such as storing it in your database
    
        redirect_to root_path, notice: 'Signed in successfully.'
      end
    def destroy
        session[:user_id] = nil
        redirect_to '/login'
    end
end
