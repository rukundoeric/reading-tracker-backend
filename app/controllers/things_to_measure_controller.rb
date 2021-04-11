class ThingsToMeasureController < ApplicationController
  def index
    @things_to_measures = ThingsToMeasure.all
    render :all, status: :ok
  end

  def create
    @things_to_measure = ThingsToMeasure.new(t_t_m_params)
    if @things_to_measure.save
      render :create, status: :created
    else
      render :not_save, status: :unprocessable_entity
    end
  end

  private

  def t_t_m_params
    params.require(:things_to_measure).permit(:value, :user_id)
  end
end