class TasksController < ApplicationController
  #! Nasser: with new action
  #before_action :require_user!, only: %i[new create destroy toggle]
  before_action :require_user!, only: %i[create destroy toggle]
  # before_action :set_locale

  #Nasser: from Bard
  def index
    @tasks = current_user.try(:tasks)
    @task = Task.new
  end

  #! Nasser: OpenAI action method from Deanin "Generative Speech AI with Turbo & Ruby on Rails 7"
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
  def show
    @task = current_user.tasks.find_by(id: params[:id])
  end

  # ! Nasser: from https://github.com/corsego/97-passwordless-auth/blob/main/app/controllers/posts_controller.rb
  #new action. got it from the tutorial
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
  #? Nasser: From Cursor
  def create
    @task = current_user.tasks.build(task_params)
    #! Nasser: from GPT
    respond_to do |format|
      if @task.save
        format.html do
          # Pass the task id to the job
          TaskToDecisionJob.perform_now(@task.id, @task.description, @task.property_type, @task.country, @task.city, @task.direction, @task.meter_street, @task.transaction_type, @task.rent_duration, @task.district, @task.land_area, @task.bedrooms, @task.bathrooms, @task.property_price, @task.selected_language, @task.price_per_meter)
          redirect_to @task, notice: "A decision is being generated. Please wait a few minutes."
          #redirect_to tasks_path, notice: "A decision is being generated. Please wait a few minutes."
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy
    redirect_to tasks_url, notice: "Post was successfully deleted."
  end

  def toggle
    @task = Task.find(params[:id])
    @task.update(completed: params[:completed])
    render json: { message: "Success" }
  end

  private

  def task_params
    params.require(:task).permit(:description, :result, :property_type, :city, :country, :direction, :meter_street, :transaction_type, :rent_duration, :district, :land_area, :bedrooms, :bathrooms, :property_price, :selected_language, :price_per_meter, :completed)
  end

  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  #   Rails.logger.debug("Current locale: #{I18n.locale}")
  #   Rails.logger.debug("Contents of ar.yml: #{I18n.backend.translations[:ar]}")
  # end
end
