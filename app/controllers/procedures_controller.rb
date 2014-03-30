class ProceduresController < ApplicationController

  before_filter :authenticate_stuff!
  before_filter :authenticate_admin!, except: :index

  expose(:procedures) { params[:search].present? ? Procedure.page(params[:page]).ordered.search(params[:search]) : Procedure.page(params[:page]).ordered }
  expose(:procedure, attributes: :permitted_params)

  def index
    respond_to do |format|
      format.html
      format.js { render layout: false }
    end
  end

  def create
    if procedure.save
      redirect_to procedures_path
    else
      render :new
    end
  end

  def update
    if procedure.save
      redirect_to procedures_path
    else
      render :edit
    end
  end

  def destroy
   procedure.destroy
    redirect_to procedures_path
  end

  private

  def permitted_params
    params.require(:procedure).permit(:icd9, :name)
  end

end
