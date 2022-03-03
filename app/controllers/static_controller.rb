class StaticController < ApplicationController
  def get_item
    send_data(Plate.find_by(id: params[:id]).image, filename: "plate")
  end
end
