class LeaguesController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :permission, only: [:edit, :update, :destroy]
    def index
        @leagues = League.all
    end

    def new
        @league = current_user.leagues.build
    end

    def show
        @league = League.find(params[:id])
    end

    def edit
        @league = League.find(params[:id])
    end

    def update
        @league = League.find(params[:id])
        if @league.update(league_params)
            redirect_to league_path
        else
            render :edit
        end
    end

    def create
        @league = current_user.leagues.build(league_params)
        if @league.save
            redirect_to root_path
        else
            render :new
        end
    end

    def destroy
        @league = League.find(params[:id])
         @league.destroy
            redirect_to root_path 
    end

    def permission
        @league = current_user.leagues.find_by(id: params[:id])
        redirect_to league_path, notice: 'You are not authorized to edit or delete this League' if @league == nil
    end

    private
    def league_params
        params.require(:league).permit(:title, :text)
    end
end
