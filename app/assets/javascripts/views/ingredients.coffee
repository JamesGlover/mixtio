class Mixtio.Views.Ingredients extends Backbone.View

  initialize: (options) ->
    @consumableTypes = options.consumableTypes
    @kitchens        = options.kitchens
    @units           = options.units
    @forRecipe       = options.forRecipe

    @collection.on('reset', () => @render())
    @collection.on('add', () => @add())

  render: () ->
    # Remove all the rows except the header
    @$el.find("tr:gt(0)").remove()

    @collection.each (ingredient) =>
      ingredientView = new Mixtio.Views.Ingredient(
        collection: @collection
        model: ingredient
        consumableTypes: @consumableTypes
        kitchens: @kitchens
        units: @units
        forRecipe: @forRecipe
      )

      @$el.append(ingredientView.render().el)

    this

  add: () ->
    ingredientView = new Mixtio.Views.Ingredient(
      collection: @collection
      model: @collection.models[@collection.length - 1]
      consumableTypes: @consumableTypes
      kitchens: @kitchens
      units: @units
      forRecipe: @forRecipe
    )

    @$el.append(ingredientView.render().el)
