class Api::V1::BatchesController < Api::V1::ApiController

  def includes
    [
        :consumable_type,
        :kitchen,
        :user,
        :ingredients,
        :consumables,
    ]
  end

end
