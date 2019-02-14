defmodule MeatApiWeb.RestaurantsController do
  use MeatApiWeb, :controller

  alias MeatApi.Restaurants
  alias MeatApi.Restaurants.Restaurant

  def index(conn, _params),
    do: render(conn, "index.json", restaurants: Restaurants.list_restaurants())
end
