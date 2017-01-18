class TasksController < ApplicationController
	# devises own method 
	before_action :authenticate_user!
	# Uses set_task bit of code only with certain methods
	before_action :set_task, only:[:edit, :update, :show, :destroy]

	def index
		@tasks = current_user.tasks
	end

	def new
		@task = Task.new
	end

	def edit
		
	end

	# Handles the new form submission
	def create
		@task = current_user.tasks.new(tasks_params)
		if @task.save
			flash[:notice] = "Task was successfully created."
			# Tasks path is found in rake routes. @task is added as route needs the specific ID
			redirect_to task_path(@task)
		else
			# renders original form back to user
			render 'new'
		end	
	end

	# Handles the edit form submission
	def update
		
		# Always remmber to whitelist e.g. send to task_params
		if @task.update(tasks_params)
			flash[:notice] = "Task was successfully updated."
			redirect_to task_path(@task)
		else
			# Renders original edit form back to user
			render 'edit'
		end
	end

	def show
		
	end

	def destroy
		
		@task.destroy
		flash[:notice] = "Task was successfully deleted."
		redirect_to tasks_path
	end

	

	private
		
	# Bit of code repeated throughout different methods	
	def set_task
		@task = Task.find(params[:id])
	end
	# Created new method for security. Saying that we want to require for the tasks
	# content to be permitted. A blog application would require title/desc etc. to be
	# required. This is called WHITELISTING.
	def tasks_params
		params.require(:task).permit(:content)
	end


end