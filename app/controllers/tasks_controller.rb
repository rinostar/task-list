class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task_id = params[:id]
    @task = Task.find_by(id: @task_id)

    if @task.nil?
      redirect_to root_path
      return
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
      return
    else
      render :new
      return
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])

    if@task.nil?
      redirect_to root_path
      return
    end
  end 

  def update
    @task = Task.find_by(id: params[:id])

    if@task.nil?
      redirect_to root_path
      return
    end

    @task = Task.find_by(id: params[:id])
    if @task.update(task_params)
      redirect_to task_path(@task)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    end

    @task.destroy

    redirect_to root_path
    return
  end

  def completed
    puts "running complete function"
    @task = Task.find_by(id: params[:id])

    if @task.nil?
      redirect_to root_path
      return
    end 
    

    if @task.completed == nil
      @task.completed = DateTime.now
      @task.save
      redirect_to root_path
      return
    else
      @task.completed = nil
      @task.save
      redirect_to root_path
      return
    end
  end

  private

  def task_params
    return params.require(:task).permit(
      :name, 
      :description, 
      :completed)
  end

end
