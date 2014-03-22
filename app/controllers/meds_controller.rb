class MedsController < ApplicationController

  before_filter :authenticate_stuff!
  before_filter :authenticate_admin!, except: :index

  expose(:meds)
  expose(:med, attributes: :permitted_params)

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
    params.require(:med).permit(:name, :form, :dose, :wrapper)
  end

end
