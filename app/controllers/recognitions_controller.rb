class RecognitionsController < ApplicationController

  before_filter :authenticate_stuff!
  before_filter :authenticate_admin!, except: :index

  expose(:recognitions) { params[:search].present? ? Recognition.page(params[:page]).ordered.search(params[:search]) : Recognition.page(params[:page]).ordered }
  expose(:recognition, attributes: :permitted_params)

  def index
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

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
