class TasksController < ApplicationController

	def new
		@task = Task.new
	end

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