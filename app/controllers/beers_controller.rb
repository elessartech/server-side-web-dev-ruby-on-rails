# frozen_string_literal: true

class BeersController < ApplicationController
  before_action :set_beer,
                only: %i[show
                         edit update destroy]

  # GET /beers or /beers.json
  def index
    @beers = Beer.all
  end

  # GET /beers/1 or /beers/1.json
  def show; end

  # GET /beers/new
  def new
    @beer = Beer.new
    @breweries = Brewery.all
    @styles = [
      'Weizen', 'Lager', 'Pale ale', 'IPA', 'Porter', 'Lowalcohol'
    ]
  end

  # GET /beers/1/edit
  def edit
    @breweries = Brewery.all
    @styles = [
      'Weizen', 'Lager', 'Pale ale', 'IPA', 'Porter', 'Lowalcohol'
    ]
  end

  # POST /beers or /beers.json
  def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html do
          redirect_to beers_url,
                      notice: 'Beer was successfully created.'
        end
        format.json do
          render :show,
                 status: :created, location: @beer
        end
      else
        format.html do
          render :new,
                 status: :unprocessable_entity
        end
        format.json do
          render json: @beer.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /beers/1 or /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html do
          redirect_to beer_url(@beer),
                      notice: 'Beer was successfully updated.'
        end
        format.json do
          render :show,
                 status: :ok, location: @beer
        end
      else
        format.html do
          render :edit,
                 status: :unprocessable_entity
        end
        format.json do
          render json: @beer.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /beers/1 or /beers/1.json
  def destroy
    @beer.destroy

    respond_to do |format|
      format.html do
        redirect_to beers_url,
                    notice: 'Beer was successfully destroyed.'
      end
      format.json do
        head :no_content
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_beer
    @beer = Beer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def beer_params
    params.require(:beer).permit(
      :name, :style, :brewery_id
    )
  end
end
