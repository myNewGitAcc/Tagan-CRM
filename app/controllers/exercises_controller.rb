class ExercisesController < ApplicationController

  skip_before_action :auth_user!
  before_action :set_exercise_lists, only: [:edit, :new]
  before_action :find_exercise, only: [:show, :edit, :update, :destroy]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.create(exercise_params)
    if @exercise.errors.empty?
      redirect_to exercise_path(@exercise)
    else
      render "new"
    end
  end

  def edit
  end

  def update
    @exercise.update_attributes(exercise_params)
    if @exercise.errors.empty?
      redirect_to exercise_path(@exercise)
    else
      render "edit"
    end
  end

  def destroy
    @exercise.destroy
    redirect_to action: "index"
  end

  def exercise_params
    params.require(:exercise).permit(:exercise_list_id, :user_id, :weight)
  end

  private

  def set_exercise_lists
    @users = User.all.map { |user| ["#{user.first_name} #{user.last_name}", user.id] }
    @exercise_lists = ExerciseList.all.map { |ex| [ex.exercise, ex.id] }
  end

  def find_exercise
    @exercise = Exercise.find(params[:id])
  end

end
