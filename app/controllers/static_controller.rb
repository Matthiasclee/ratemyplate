class StaticController < ApplicationController
  def get_lic_plate
    send_data(Plate.find_by(id: params[:id]).image, filename: "plate")
  end
  def get_additional_lic_plate
    send_data(Plate.find_by(id: params[:id]).images[params[:num].to_i].undump, filename: "plate")
  end
  def get_blank_plate
    send_file(Rails.root.join("public", "state_license_plates", "#{params[:state]}.jpeg"))
  end
end
