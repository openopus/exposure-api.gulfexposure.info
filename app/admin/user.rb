ActiveAdmin.register User do
  permit_params :guid, :birthdate, :codename, :latitude, :longitude
end
