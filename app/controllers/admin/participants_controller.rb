class Admin::ParticipantsController < Admin::AdminApplicationController
  before_action :set_participant, only: [:show, :edit, :update, :destroy, :targets]

  # GET /participants
  def index
    @participants = Participant.all
  end

  # GET /participants/1
  def show
    @participant_info ||= EtuUtt::Api.get(current_access_token, 'public/users/'+ @participant.login )
  end

  # GET /participants/new
  def new
    @participant = Participant.new
  end

  # GET /participants/1/edit
  def edit
  end

  def targets
  end

  def loop
    @participants = Participant.validated.all
  end

  def start 
    Game.current.allocate_players_targets
  end

  # POST /participants
  def create
    @participant = Participant.new(participant_params)
    @participant.game = Game.last
    if @participant.save
      redirect_to @participant, notice: 'Participant was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /participants/1
  def update
    if @participant.update(participant_params)
      redirect_to @participant, notice: 'Participant was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /participants/1
  def destroy
    @participant.destroy
    redirect_to participants_url, notice: 'Participant was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participant
      @participant = Participant.find_by_login(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def participant_params
      params.require(:participant).permit(:login, :paid, :game_id)
    end
end
