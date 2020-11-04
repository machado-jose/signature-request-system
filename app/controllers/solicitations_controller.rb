class SolicitationsController < ApplicationController
  before_action :set_solicitation, only: [:show, :destroy]

  # GET /solicitations
  # GET /solicitations.json
  def index
    @solicitations = Solicitation.all
  end

  # GET /solicitations/1
  # GET /solicitations/1.json
  def show
  end

  # GET /solicitations/new
  def new
    @solicitation = Solicitation.new
  end

  # POST /solicitations
  # POST /solicitations.json
  def create
    @solicitation = Solicitation.new(solicitation_params)
    if @solicitation.save!
      redirect_to solicitations_path, notice: 'Solicitation was saved with success!'
    else
      redirect_to solicitations_path, notice: 'Request submission failed!'
    end
  end

  # DELETE /solicitations/1
  # DELETE /solicitations/1.json
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
      params.require(:solicitation).permit(:signatory_id, :document_id, :description)
    end
end
