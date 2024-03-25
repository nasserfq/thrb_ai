module Admin
  class UsersController < Admin::ApplicationController
    # include Passwordless::ControllerHelpers # <-- This!
    # (unless you already have it in your ApplicationController)
    # helper_method :current_user
    #passwordless_with :email

    #before_action :set_locale
    #  def index
    #   @users = Admin.all
    # end

    # def current_user
    #   @current_user ||= authenticate_by_session(User)
    # end

    # def require_user!
    #   return if current_user
    #   save_passwordless_redirect_location!(User) # <-- this one!
    #   redirect_to root_path, flash: { error: "You are not worthy!" }
    # end

    # def index
    #   @users = User.all
    # end

    # #!Nasser: Trial and error
    # # def new
    # #   @user = User.new
    # # end
    # #!Nasser: From ChatGPT
    # def show
    #   @user = User.find(params[:id])
    # end

    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    #  

    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end

    # The result of this lookup will be available as `requested_resource`

    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end

    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end

    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
