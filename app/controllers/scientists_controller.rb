class ScientistsController < ApplicationController

    def index 
        render json: Scientist.all , status: :ok 
    end 

    def show
        scientist = find_scientist
        if scientist.present?
            render json: scientist,  serializer: ScientistPlanetsSerializer, status: :ok
        else
            render json: {error: 'Scientist not found'}, status: :not_found
        end
    end

    def update 
        scientist = find_scientist
        if scientist.present?
            scientist.update!(scientist_params)
            render json: scientist, status: :accepted
        else 
            render json: {error: "Scientist not found"}, status: :not_found
        end 
    rescue ActiveRecord::RecordInvalid => e 
        render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def create 
        scientist = Scientist.create!(scientist_params)
            render json: scientist , status: :created 
        rescue ActiveRecord::RecordInvalid => e 
            render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
    end 

    def destroy 
        scientist = find_scientist
        if scientist.present?
            scientist.destroy
            head :no_content
        else 
            render json: {error: "Scientist not found"}, status: :not_found
        end
    end 

    private 

    def scientist_params
        params.permit(:name, :field_of_study, :avatar)
        
    end 

    def find_scientist
        Scientist.find_by(id: params[:id])
    end 

    
end
