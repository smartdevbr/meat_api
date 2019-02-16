defmodule MeatApiWeb.RestaurantsView do
  use MeatApiWeb, :view
  alias MeatApiWeb.RestaurantsView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantsView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{
      data: %{
        id: restaurant.id,
        image: restaurant.image,
        name: restaurant.name,
        description: restaurant.description
      }
    }
  end

  def render("restaurant.json", %{restaurant: restaurant}) do
    %{
      id: restaurant.id,
      image: restaurant.image,
      name: restaurant.name,
      description: restaurant.description
    }
  end
end
