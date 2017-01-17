class TasksController < ApplicationController

	def new
		@task = Task.new
	end

	def edit
		@task = Task.find(params[:id])
	end

	# Handles the new form submission
	def create
		@task = Task.new(tasks_params)
		if @task.save
			flash[:notice] = "Task was successfully created"
			# Tasks path is found in rake routes. @task is added as route needs the specific ID
			redirect_to task_path(@task)
		else
			# renders original form back to user
			render 'new'
		end	
	end

	# Handles the edit form submission
	def update
		@task = Task.find(params[:id])
		# Always remmber to whitelist e.g. send to task_params
		if @task.update(tasks_params)
			flash[:notice] = "Task was successfully updated"
			redirect_to task_path(@task)
		else
			# Renders original edit form back to user
			render 'edit'
		end
	end

	def show
		@task = Task.find(params[:id])
	end

	

	private
	# Created new method for security. Saying that we want to require for the tasks
	# content to be permitted. A blog application would require title/desc etc. to be
	# required. This is called WHITELISTING.
	def tasks_params
		params.require(:task).permit(:content)
	end


end