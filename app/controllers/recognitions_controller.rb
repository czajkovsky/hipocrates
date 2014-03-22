class RecognitionsController < ApplicationController

  expose(:recognitions)
  expose(:recognition, attributes: :permitted_params)

  def create
    if recognition.save
      redirect_to recognitions_path
    else
      render :new
    end
  end

  def update
    if recognition.save
      redirect_to recognitions_path
    else
      render :edit
    end
  end

  def destroy
   recognition.destroy
    redirect_to recognitions_path
  end

  private

  def permitted_params
    params.require(:recognition).permit(:icd9, :name)
  end

end
