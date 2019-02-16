defmodule MeatApiWeb.RestaurantView do
  use MeatApiWeb, :view
  alias MeatApiWeb.RestaurantView

  def render("index.json", %{restaurants: restaurants}) do
    %{data: render_many(restaurants, RestaurantView, "restaurant.json")}
  end

  def render("show.json", %{restaurant: restaurant}) do
    %{data: render_one(restaurant, RestaurantView, "restaurant.json")}
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
