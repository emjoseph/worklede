class ResumesController < ApplicationController

  def index

  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def finish
  end

end
