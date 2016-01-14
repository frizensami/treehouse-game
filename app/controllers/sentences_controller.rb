class SentencesController < ApplicationController
  before_action :set_sentence, only: [:show, :edit, :update, :destroy]
  before_action :validate_user

  def house_latest
    user_house_id = session[:user]["house_id"]
    @house_name = House.find(user_house_id).name
    @latest_sentence = Sentence.where(house_id: user_house_id).order("created_at").last.try(:sentence_text)
    @sentence = Sentence.new
  end

  # GET /sentences
  # GET /sentences.json
  def index
    @sentences = Sentence.all
  end

  # GET /sentences/1
  # GET /sentences/1.json
  def show
  end

  # GET /sentences/new
  def new
    @sentence = Sentence.new
  end

  # GET /sentences/1/edit
  def edit
  end

  # POST /sentences
  # POST /sentences.json
  def create
    @sentence = Sentence.new(sentence_params)

    respond_to do |format|
      if @sentence.save
        format.html { redirect_to house_latest_path, notice: 'Sentence was successfully created.' }
        format.json { render :show, status: :created, location: @sentence }
      else
        format.html { render :new }
        format.json { render json: @sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sentences/1
  # PATCH/PUT /sentences/1.json
  def update
    respond_to do |format|
      if @sentence.update(sentence_params)
        format.html { redirect_to @sentence, notice: 'Sentence was successfully updated.' }
        format.json { render :show, status: :ok, location: @sentence }
      else
        format.html { render :edit }
        format.json { render json: @sentence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sentences/1
  # DELETE /sentences/1.json
  def destroy
    @sentence.destroy
    respond_to do |format|
      format.html { redirect_to sentences_url, notice: 'Sentence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def validate_user
      p session[:user]
      unless session.has_key?("user") && User.exists?(name: session[:user]["name"],
                                                      matric: session[:user]["matric"],
                                                      room_number: session[:user]["room_number"])
        redirect_to login_path, flash: {problem: "Authentication failed, could not validate matric and room number."}
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_sentence
      @sentence = Sentence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sentence_params
      mod_params = params.require(:sentence).permit(:house_id, :user_id, :sentence_text)
      mod_params[:house_id] = session[:user]["house_id"] if mod_params[:house_id].blank?
      mod_params[:user_id] = session[:user]["id"] if mod_params[:user_id].blank?
      return mod_params
    end
end
