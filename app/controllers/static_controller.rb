class StaticController < ApplicationController
  def get_item
    send_file Rails.root.join('public', 'uploads', params[:filename]), filename: params[:filename][0...-51]
  end
end
