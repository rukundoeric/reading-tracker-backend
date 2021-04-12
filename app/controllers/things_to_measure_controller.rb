class ThingsToMeasureController < ApplicationController
  before_action :verify_token, only: %i[index create]
  before_action :set_t_t_measure, only: %i[destroy]
  before_action :check_is_admin, only: %i[create]

  def index
    @things_to_measures = ThingsToMeasure.all.eager_loading
    render :all, status: :ok
  end

  def create
    @things_to_measure = current_user.things_to_measures.new(t_t_m_params)
    if @things_to_measure.save
      render :create, status: :created
    else
      @error = @things_to_measure.errors
      render :error, status: :unprocessable_entity
    end
  end

  def destroy
    @things_to_measure.destroy
    render :destroy, status: :ok
  end

  private

  def check_is_admin
    if !current_user.is_admin?
      render :no_access, status: :forbidden
    end
  end  

  def set_t_t_measure
    @things_to_measure = Measurement.find(params[:id])
  rescue StandardError => e
    @error = e
    render :error, status: :not_found
  end

  def t_t_m_params
    params.require(:things_to_measure).permit(:name, :unit)
  end
end
