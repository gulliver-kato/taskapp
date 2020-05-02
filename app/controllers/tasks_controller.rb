# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if logged_in?

      if params[:sort_expired]
        @tasks = current_user.tasks.all.order(end_date: 'DESC').page(params[:page]).per(10)
      elsif params[:sort_priority]
        @tasks = current_user.tasks.all.order(priority: 'ASC').page(params[:page]).per(10)
      elsif
        @tasks = current_user.tasks.all.order(created_at: 'DESC').page(params[:page]).per(10)
      end

      if params[:search].present?
        if params[:name].present? && params[:status].present?
          @tasks = current_user.tasks.name_search(params[:name]).status_search(params[:status]).page(params[:page]).per(10)
        elsif params[:name].present?
          @tasks = current_user.tasks.name_search(params[:name]).page(params[:page]).per(10)
        elsif params[:status].present?
          @tasks = current_user.tasks.status_search(params[:status]).page(params[:page]).per(10)
        end
      end
    else
      redirect_to new_session_path, notice: t('view.task.login')
    end
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit; end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :content, :end_date, :priority, :status)
  end
end
