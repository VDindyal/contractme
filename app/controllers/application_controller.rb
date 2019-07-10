include ActionView::Helpers::UrlHelper
include ApplicationHelper

class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    protect_from_forgery with: :exception

    check_authorization :unless => :devise_controller?
    skip_authorization_check :only => [:landing, :set_current_user]

    before_action :configure_permitted_parameters, if: :devise_controller?

    before_action :set_user

    after_action :store_location

    def landing
        if user_signed_in?
            # if !current_user.nil?
            #     if current_user.confirmed_at.blank?
            #         if current_user.unconfirmed_email.blank?
            #             redirect_to collect_email_path and return
            #         end
            #
            #         redirect_to pending_email_confirmation_path and return
            #     end
            # end

            redirect_to postings_path and return # Change to the initial state of the given user type
        end

        redirect_to new_user_session_path and return
    end

    protected

    def store_location
        # store last url - this is needed for post-login redirect to whatever the user last visited.
        return unless request.get?
        if (request.path != "/users/sign_in" &&
            request.path != "/users/sign_up" &&
            request.path != "/users/password/new" &&
            request.path != "/users/password/edit" &&
            request.path != "/users/confirmation" &&
            request.path != "/users/sign_out" &&
            !request.xhr?) # don't store ajax calls
            session[:previous_url] = request.fullpath
        end
    end

    def set_user
        if (current_user)
            @user = User.find(current_user.id)
            gon.user_id = current_user.id
        end
    end

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :name, :password, :password_confirmation, :unconfirmed_email, :phone_number])
        devise_parameter_sanitizer.permit(:account_update, keys: [:email, :name, :password, :password_confirmation, :current_password, :unconfirmed_email, :phone_number])
    end

    def send_confirmation_instructions(user)
        begin
            user.send_confirmation_instructions
            gflash :success => "An email has been sent to \"#{user.unconfirmed_email}\". Please click on the activation link in the email."
        rescue => ex
            gflash :error => "Nothing happened. There was a problem sending a confirmation email: " + ex.to_s
            logger.error("Problem sending confirmation instructions for " + @user.name + ": " + ex.to_s + "\n" + ex.backtrace.join("\n\t"))
        end
    end
end
