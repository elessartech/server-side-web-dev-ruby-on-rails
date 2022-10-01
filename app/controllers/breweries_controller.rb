# frozen_string_literal: true

class BreweriesController < ApplicationController
  before_action :set_brewery,
                only: %i[show
                         edit update destroy]
  before_action :ensure_that_signed_in, except: %i[index show]

  # GET /breweries or /breweries.json
  def index
    @breweries = Brewery.all
    render :index # renderöi hakemistossa view/breweries olevan näkymätemplaten index.html.erb
  end

  # GET /breweries/1 or /breweries/1.json
  def show; end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit; end

  # POST /breweries or /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)

    respond_to do |format|
      if @brewery.save
        format.html do
          redirect_to brewery_url(@brewery),
                      notice: 'Brewery was successfully created.'
        end
      else
        format.html do
          render :new,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /breweries/1 or /breweries/1.json
  def update
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html do
          redirect_to brewery_url(@brewery),
                      notice: 'Brewery was successfully updated.'
        end
      else
        format.html do
          render :edit,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /breweries/1 or /breweries/1.json
  def destroy
    @brewery.destroy

    respond_to do |format|
      format.html do
        redirect_to breweries_url,
                    notice: 'Brewery was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_brewery
    @brewery = Brewery.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def brewery_params
    params.require(:brewery).permit(
      :name, :year
    )
  end
end
