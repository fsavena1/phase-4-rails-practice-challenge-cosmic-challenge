class NewMissionSerializer < ActiveModel::Serializer
  attributes :id, :name 
  has_one :planet
end
