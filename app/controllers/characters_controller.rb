class CharactersController < ApplicationController
  def index
    @characters = Character.all
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    @character.television_show_id = params[:television_show_id]

    if @character.save
      flash[:notice] = "Success!"
      redirect_to "/television_shows/#{params[:television_show_id]}"

    else
      flash[:notice] = "Your Character could not be saved!"
      redirect_to "/television_shows/#{params[:television_show_id]}"

    end
  end

private
  def character_params
    params.require(:character).permit(:name, :actor, :description, :television_show_id)
  end
end
