class Plate < ApplicationRecord
  states = %w(AK AL AR AZ CA CO CT DC DE FL GA HI IA ID IL IN KS KY LA MA MD ME MI MN MO MS MT NC ND NE NH NJ NM NV NY OH OK OR PA RI SC SD TN TX UT VA VT WA WI WV WY)

  validates :plate, length: { maximum: 7, minimum: 1 }
  validates :plate, format: { without: /\s/, message: "can not contain spaces" }
  validates :plate, format: { without: /[\W]/, message: "must only contain valid characters (A-Z 1-9)" }
  validates :state, inclusion: { in: states, message: "must be a valid US state (NV, CA, NY ...)" }
end
