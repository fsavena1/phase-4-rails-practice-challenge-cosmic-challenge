class MissionsController < ApplicationController



    def create 
        mission = Mission.create!(mission_params)
        render json: mission.planet, status: 201
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 

    private 

    def mission_params
        params.permit(:name, :scientist_id, :planet_id)
    end 


end