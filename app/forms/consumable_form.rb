class ConsumableForm
  include ActiveModel::Model

  validate :check_consumable

  attr_reader :consumable

  ATTRIBUTES = [:name, :expiry_date, :lot_number, :arrival_date, :supplier, :consumable_type_id, :parent_ids]
  delegate *ATTRIBUTES, :id, to: :consumable

  def self.model_name
    ActiveModel::Name.new(Consumable, nil, nil)
  end

  def initialize(consumable = Consumable.new)
    @consumable = consumable
  end

  def submit(params)
    consumable.attributes = params[:consumable].slice(*ATTRIBUTES).permit!
    if valid?
      if consumable.new_record?
        @consumables = consumable.save_or_mix(params[:consumable][:limit] || 1)
        true
      else
        consumable.save
      end
    else
      false
    end
  end

  def consumables
    @consumables ||= []
  end

  def persisted?
    consumable.id?
  end

  private

  def check_consumable
    unless consumable.valid?
      consumable.errors.each do |key, value|
        errors.add key, value
      end
    end
  end
end