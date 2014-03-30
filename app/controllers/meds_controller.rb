class MedsController < ApplicationController

  before_filter :authenticate_stuff!
  before_filter :authenticate_admin!, except: :index

  expose(:meds) { params[:search].present? ? Med.page(params[:page]).ordered.search(params[:search]) : Med.page(params[:page]).ordered }
  expose(:med, attributes: :permitted_params)

  def index
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    if med.save
      redirect_to meds_path
    else
      render :new
    end
  end

  def update
    if med.save
      redirect_to meds_path
    else
      render :edit
    end
  end

  def destroy
   med.destroy
    redirect_to meds_path
  end

  private

  def permitted_params
    params.require(:med).permit(:name, :form)
  end

end
