class SolicitationsController < ApplicationController
  before_action :set_solicitation, only: [:show, :destroy]

  # GET /solicitations
  def index
    @solicitations = Solicitation.all.page params[:page]
  end

  # GET /solicitations/1
  def show
    @solicitation = Solicitation.find(params[:id])
  end

  # GET /solicitations/new
  def new
    @solicitation = Solicitation.new
  end

  # POST /solicitations
  def create
    @solicitation = Solicitation.new(solicitation_params)
    if @solicitation.save!
      respost = SignatureServices::CreateSignatures.new(@solicitation.id).call
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

  # DELETE /solicitations/1
  def destroy
    @solicitation.destroy
    
    redirect_to solicitations_path, notice: 'Solicitation was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_solicitation
    @solicitation = Solicitation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
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
