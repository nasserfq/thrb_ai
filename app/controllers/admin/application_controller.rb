# All Administrate controllers inherit from this
# `Administrate::ApplicationController`, making it the ideal place to put
# authentication logic or other before_actions.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    #before_action :authenticate_admin
    # include Passwordless::ControllerHelpers
    # helper_method :current_user
    http_basic_authenticate_with(
      name: Rails.application.credentials.ADMIN_NAME,
      password: Rails.application.credentials.ADMIN_PASSWORD,
    )
    # def index
    #   @users = User.where("email = ?", email)
    # end

    # def current_user
    #   @current_user ||= authenticate_by_session(User)
    # end

    # Used in listings, such as the `index` actions. It
    # restricts the scope of records that a user can access.
    # Returns an ActiveRecord scope.
    # def scoped_resource
    #   super.where(user: current_user)
    # end

    # Return true if the current user can access the given
    # resource, false otherwise.
    # def authorized_action?(resource, action)
    #   current_user.can?(resource, action)
    # end

    
   

    # def authenticate_admin
    #   # TODO Add authentication logic here.
    # end

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end
  end
end
