class Plate < ApplicationRecord
  validates :plate, length: { maximum: 7, minimum: 1 }
  validates :plate, format: { without: /\s/, message: "can not contain spaces" }
end
