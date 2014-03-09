class SpecialitiesController < ApplicationController

  expose(:specialities)
  expose(:speciality, attributes: :permitted_params)

  def create
    if speciality.save
      redirect_to specialities_path
    else
      render :new
    end
  end

  def update
    if speciality.save
      redirect_to specialities_path
    else
      render :edit
    end
  end

  def destroy
    speciality.destroy
    redirect_to specialities_path
  end

  private

  def permitted_params
    params.require(:speciality).permit(:name)
  end

end
