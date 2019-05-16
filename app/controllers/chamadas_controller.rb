class ChamadasController < ApplicationController
  before_action :set_chamada, only: [:show, :edit, :update, :destroy]

  def sintetico
    @chamadas = Chamada.all

    if params[:q].present?
      if not params[:q].include?(",")
        login_like = Chamada.arel_table[:login]
        telefone_like = Chamada.arel_table[:destino_numero]
        @chamadas = @chamadas.where(login_like.matches("%#{params[:q]}%")).or(@chamadas.where(telefone_like.matches("%#{params[:q]}%")))
      else
        query = []
        params[:q].split(",").map{|q|q.strip}.each do |q|
          if Rails.env == "production"
            query << " chamadas.login ilike '%#{q}%' OR chamadas.destino_numero ilike '%#{q}%' "
          else
            query << " chamadas.login like '%#{q}%' OR chamadas.destino_numero like '%#{q}%' "
          end
        end
        @chamadas = @chamadas.where("( #{query.join(" or ")} )")
      end
    end

    if params[:data_de].present? && params[:data_ate].present?
      data_de = DateTime.parse(params[:data_de]).beginning_of_day
      data_ate = DateTime.parse(params[:data_ate]).end_of_day
      @chamadas = @chamadas.where("data_criacao >= '#{data_de.strftime("%Y-%m-%d %H:%M:%S")}'")
      @chamadas = @chamadas.where("data_criacao <= '#{data_ate.strftime("%Y-%m-%d %H:%M:%S")}'")
    elsif params[:data_de].present? && params[:data_ate].blank?
      data_de = DateTime.parse(params[:data_de]).beginning_of_day
      @chamadas = @chamadas.where("data_criacao >= '#{data_de.strftime("%Y-%m-%d %H:%M:%S")}'")
    elsif params[:data_de].blank? && params[:data_ate].present?
      data_ate = DateTime.parse(params[:data_ate]).end_of_day
      @chamadas = @chamadas.where("data_criacao <= '#{data_ate.strftime("%Y-%m-%d %H:%M:%S")}'")
    end

    if params[:duracao_de].present? && params[:duracao_ate].present?
      duracao_de = Time.parse(params[:duracao_de])
      duracao_ate = Time.parse(params[:duracao_ate])
      @chamadas = @chamadas.where("destino_duracao_cobrada >= '#{duracao_de.strftime("%H:%M:%S")}'")
      @chamadas = @chamadas.where("destino_duracao_cobrada <= '#{duracao_ate.strftime("%H:%M:%S")}'")
    elsif params[:duracao_de].present? && params[:duracao_ate].blank?
      duracao_de = Time.parse(params[:duracao_de])
      @chamadas = @chamadas.where("destino_duracao_cobrada >= '#{duracao_de.strftime("%H:%M:%S")}'")
    elsif params[:duracao_de].blank? && params[:duracao_ate].present?
      duracao_ate = Time.parse(params[:duracao_ate])
      @chamadas = @chamadas.where("destino_duracao_cobrada <= '#{data_ate.strftime("%H:%M:%S")}'")
    end

  end

  def index
    @chamadas = Chamada.all

    if params[:q].present?
      if not params[:q].include?(",")
        login_like = Chamada.arel_table[:login]
        telefone_like = Chamada.arel_table[:destino_numero]
        @chamadas = @chamadas.where(login_like.matches("%#{params[:q]}%")).or(@chamadas.where(telefone_like.matches("%#{params[:q]}%")))
      else
        query = []
        params[:q].split(",").map{|q|q.strip}.each do |q|
          if Rails.env == "production"
            query << " chamadas.login ilike '%#{q}%' OR chamadas.destino_numero ilike '%#{q}%' "
          else
            query << " chamadas.login like '%#{q}%' OR chamadas.destino_numero like '%#{q}%' "
          end
        end
        @chamadas = @chamadas.where("( #{query.join(" or ")} )")
      end
    end

    if params[:chamada_voice_id].present?
      @chamadas = @chamadas.where(chamada_voice_id: params[:chamada_voice_id])
    end

    if params[:status].present?
      @chamadas = @chamadas.where(destino_status: params[:status])
    end

    if params[:data_de].present? && params[:data_ate].present?
      data_de = DateTime.parse(params[:data_de]).beginning_of_day
      data_ate = DateTime.parse(params[:data_ate]).end_of_day
      @chamadas = @chamadas.where("data_criacao >= '#{data_de.strftime("%Y-%m-%d %H:%M:%S")}'")
      @chamadas = @chamadas.where("data_criacao <= '#{data_ate.strftime("%Y-%m-%d %H:%M:%S")}'")
    elsif params[:data_de].present? && params[:data_ate].blank?
      data_de = DateTime.parse(params[:data_de]).beginning_of_day
      @chamadas = @chamadas.where("data_criacao >= '#{data_de.strftime("%Y-%m-%d %H:%M:%S")}'")
    elsif params[:data_de].blank? && params[:data_ate].present?
      data_ate = DateTime.parse(params[:data_ate]).end_of_day
      @chamadas = @chamadas.where("data_criacao <= '#{data_ate.strftime("%Y-%m-%d %H:%M:%S")}'")
    end

    if params[:duracao_de].present? && params[:duracao_ate].present?
      duracao_de = Time.parse(params[:duracao_de])
      duracao_ate = Time.parse(params[:duracao_ate])
      @chamadas = @chamadas.where("destino_duracao_cobrada >= '#{duracao_de.strftime("%H:%M:%S")}'")
      @chamadas = @chamadas.where("destino_duracao_cobrada <= '#{duracao_ate.strftime("%H:%M:%S")}'")
    elsif params[:duracao_de].present? && params[:duracao_ate].blank?
      duracao_de = Time.parse(params[:duracao_de])
      @chamadas = @chamadas.where("destino_duracao_cobrada >= '#{duracao_de.strftime("%H:%M:%S")}'")
    elsif params[:duracao_de].blank? && params[:duracao_ate].present?
      duracao_ate = Time.parse(params[:duracao_ate])
      @chamadas = @chamadas.where("destino_duracao_cobrada <= '#{data_ate.strftime("%H:%M:%S")}'")
    end
      
    @chamadas_total = @chamadas
    
    options = {page: params[:page] || 1, per_page: 10}
    @chamadas = @chamadas.paginate(options)
  end

  # GET /chamadas/1
  # GET /chamadas/1.json
  def show
  end

  # GET /chamadas/new
  def new
    @chamada = Chamada.new
  end

  # GET /chamadas/1/edit
  def edit
  end

  # POST /chamadas
  # POST /chamadas.json
  def create
    @chamada = Chamada.new(chamada_params)

    respond_to do |format|
      if @chamada.save
        format.html { redirect_to @chamada, notice: 'Chamada was successfully created.' }
        format.json { render :show, status: :created, location: @chamada }
      else
        format.html { render :new }
        format.json { render json: @chamada.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chamadas/1
  # PATCH/PUT /chamadas/1.json
  def update
    respond_to do |format|
      if @chamada.update(chamada_params)
        format.html { redirect_to @chamada, notice: 'Chamada was successfully updated.' }
        format.json { render :show, status: :ok, location: @chamada }
      else
        format.html { render :edit }
        format.json { render json: @chamada.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chamadas/1
  # DELETE /chamadas/1.json
  def destroy
    @chamada.destroy
    respond_to do |format|
      format.html { redirect_to chamadas_url, notice: 'Chamada was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chamada
      @chamada = Chamada.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chamada_params
      params.require(:chamada).permit(:chamada_voice_id, :data_criacao, :ativa, :url_gravacao, :cliente_id, :conta_id, :ramal_id_origem, :tags, :status_geral, :origem_data_inicio, :origem_numero, :origem_tipo, :origem_status, :origem_duracao_segundos, :origem_duracao, :origem_duracao_cobrada_segundos, :origem_duracao_cobrada, :origem_duracao_falada_segundos, :origem_duracao_falada, :origem_preco, :origem_motivo_desconexao, :destino_data_inicio, :destino_numero, :destino_tipo, :destino_status, :destino_duracao_segundos, :destino_duracao, :destino_duracao_cobrada_segundos, :destino_duracao_cobrada, :destino_duracao_falada_segundos, :destino_duracao_falada, :destino_preco, :destino_motivo_desconexao)
    end
end
