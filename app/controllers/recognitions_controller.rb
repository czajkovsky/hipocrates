class RecognitionsController < ApplicationController

  before_filter :authenticate_stuff!
  before_filter :authenticate_admin!, except: :index

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
    params.require(:recognition).permit(:icd10, :name)
  end

end
