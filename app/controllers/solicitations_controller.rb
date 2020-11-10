class SolicitationsController < ApplicationController
  before_action :set_solicitation, only: [:show, :destroy]

  def index
    @solicitations = Solicitation.all.page params[:page]
  end

  def show
    @solicitation = Solicitation.find(params[:id])
  end

  def new
    @solicitation = Solicitation.new
  end

  def create
    respost = SolicitationServices::CreateSolicitation.new(solicitation_params).call
    if respost.success?
      respost = SignatureServices::CreateSignatures.new(respost.solicitation.id).call
      if respost.success?
        redirect_to solicitations_path, flash: {notice_success: 'Solicitation was saved with success!'}
      else
        @solicitation.destroy
        redirect_to solicitations_path, flash: { notice_danger: 'Request submission failed!'}
      end
    else
      redirect_to solicitations_path, flash: { notice_danger: 'Request submission failed!'}
    end
  end

  def cancel
    @solicitation = Solicitation.find(params[:id])
    @solicitation.update(:is_canceled => true)
    redirect_to solicitations_path, notice: 'Solicitation was successfully canceled.'
  end

  private
  
  def set_solicitation
    @solicitation = Solicitation.find(params[:id])
  end

  def solicitation_params
    params.require(:solicitation).permit(
      :document, 
      signatories_attributes: [
        :id, 
        :name, 
        :email, 
        :_destroy]
        )
  end
end
