class PlanetsController < ApplicationController

    def index
        
        render json: Planet.all, status: 200
    end 
end
