class TasksController < ApplicationController
  # ! Nasser: with new action
  # before_action :require_user!, only: %i[new create destroy toggle]
  # ? Nasser:  will be uncomment soon
  # before_action :require_user!, only: %i[create destroy toggle]
  # before_action :set_locale

  # Nasser: from Bard
  def index
    # ? Nasser:  will be uncomment soon
    # @tasks = current_user.try(:tasks)
    # @task = Task.new

    @tasks = Task.all
    @task = Task.new
  end

  def show
    @task = Task.find_by(id: params[:id])
    # if params[:id] == 'fetch_country_states'
    #   fetch_country_states
    # else
    #   @task = Task.find(params[:id])
    # end
  end

  # def show
  #   @task = Task.find(params[:id])
  # end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html do
          puts "task_id: #{@task.id}"
          puts "description: #{@task.description}"
          puts "property_type: #{@task.property_type}"
          puts "country: #{@task.country}"
          puts "city: #{@task.city}"
          puts "direction: #{@task.direction}"
          puts "meter_street: #{@task.meter_street}"
          puts "transaction_type: #{@task.transaction_type}"
          puts "rent_duration: #{@task.rent_duration}"
          puts "district: #{@task.district}"
          puts "land_area: #{@task.land_area}"
          puts "bedrooms: #{@task.bedrooms}"
          puts "bathrooms: #{@task.bathrooms}"
          puts "property_price: #{@task.property_price}"
          puts "selected_language: #{@task.selected_language}"
          puts "price_per_meter: #{@task.price_per_meter}"
          TaskToDecisionJob.perform_now(@task.id, @task.description, @task.property_type, @task.country, @task.city,
                                        @task.direction, @task.meter_street, @task.transaction_type, @task.rent_duration, @task.district, @task.land_area, @task.bedrooms, @task.bathrooms, @task.property_price, @task.selected_language, @task.price_per_meter)
          redirect_to @task
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def fetch_country_states
    # @target = params[:target]
    # country = ISO3166::Country[params[:country_code]]
    # @states = country.states.map { |state| [state.first, state[1].translations[I18n.locale.to_s]] }
    # @target = params[:target]
    # @states = CS.get(params[:country]).invert
    @target = params[:target]
    country_code = params[:country]
    country = ISO3166::Country[country_code]
    @country_name = country.translations[I18n.locale.to_s] || country.name
    @states = country.states.map { |state_code, state_info| [state_info['name'], state_code] }
    # Debugging Statements:
    puts "Received Country: #{country_code}"
    puts "Country Name: #{@country_name}"
    puts "Fetched States: #{@states.inspect}"
    respond_to do |format|
      format.turbo_stream
    end
  end

  # ! Nasser: OpenAI action method from Deanin "Generative Speech AI with Turbo & Ruby on Rails 7"
  # def tts
  #   # TaskToDecisionJob.perform_later(task_params[:description])
  #   # redirect_to root_path, notice: "A decision is being generated. Please wait a few minutes."
  #   #? Nasser: From Cursor
  #   task = Task.create(description: task_params[:description])
  #   TaskToDecisionJob.perform_later(task.id, task.description)
  #   redirect_to root_path, notice: "A decision is being generated. Please wait a few minutes."
  # end

  # def task_posts
  #   @tasks = Task.all.map do |task|

  #     task.description = "Random Description #{rand(100)}"
  #     task
  #   end

  #   render layout: false # Don't forget this optimization!
  # end
  # ? Nasser:  will be uncomment soon
  # def show
  #   @task = current_user.tasks.find_by(id: params[:id])
  # end

  # ! Nasser: from https://github.com/corsego/97-passwordless-auth/blob/main/app/controllers/posts_controller.rb
  # new action. got it from the tutorial
  # def new
  #   @task = Task.new
  # end
  # def create
  #   @task = current_user.tasks.build(task_params)
  #   #! Nasser: from GPT
  #   respond_to do |format|
  #     if @task.save
  #       format.html do
  #         redirect_to tasks_url, notice: "Task was successfully created"
  #       end
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end
  # ? Nasser: From Cursor
  # ? Nasser:  will be uncomment soon
  # def create
  #   @task = current_user.tasks.build(task_params)
  #   #! Nasser: from GPT
  #   respond_to do |format|
  #     if @task.save
  #       format.html do
  #         # Pass the task id to the job
  #         TaskToDecisionJob.perform_now(@task.id, @task.description, @task.property_type, @task.country, @task.city, @task.direction, @task.meter_street, @task.transaction_type, @task.rent_duration, @task.district, @task.land_area, @task.bedrooms, @task.bathrooms, @task.property_price, @task.selected_language, @task.price_per_meter)
  #         redirect_to @task, notice: "A decision is being generated. Please wait a few minutes."
  #         #redirect_to tasks_path, notice: "A decision is being generated. Please wait a few minutes."
  #       end
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # ? Nasser:  will be uncomment soon
  # def destroy
  #   @task = current_user.tasks.find_by(id: params[:id])
  #   @task.destroy
  #   redirect_to tasks_url, notice: "Post was successfully deleted."
  # end

  # ? Nasser:  will be uncomment soon
  # def toggle
  #   @task = Task.find(params[:id])
  #   @task.update(completed: params[:completed])
  #   render json: { message: "Success" }
  # end

  private

  def task_params
    permitted_params = params.require(:task).permit(:description, :result, :property_type, :city, :country, :direction,
                                                    :meter_street, :transaction_type, :rent_duration, :district, :land_area, :bedrooms, :bathrooms, :property_price, :selected_language, :price_per_meter, :state, :target, :completed)
    # If the form sends the country name as a separate parameter, you can fetch it like this:
    country_name = params[:country_name] || ISO3166::Country[params[:task][:country]].translations[I18n.locale.to_s]

    # Then merge it into the task parameters
    permitted_params.merge(country: country_name)
  end

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  #   Rails.logger.debug("Current locale: #{I18n.locale}")
  #   Rails.logger.debug("Contents of ar.yml: #{I18n.backend.translations[:ar]}")
  # end
end
