defmodule MeatApiWeb.RestaurantsController do
  use MeatApiWeb, :controller
  use PhoenixSwagger

  alias MeatApi.Restaurants
  alias MeatApi.Restaurants.Restaurant

  action_fallback MeatApiWeb.FallbackController

  def index(conn, _params),
    do: render(conn, "index.json", restaurants: Restaurants.list_restaurants())

  def show(conn, %{"id" => id}) do
    render(conn, "show.json", restaurant: Restaurants.get_restaurant!(id))
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    with {:ok, restaurant} <- Restaurants.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurants_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  def delete(conn, %{"id" => id}) do
    with restaurant = %Restaurant{} <- Restaurants.get_restaurant!(id) do
      Restaurants.delete_restaurant(restaurant)
      send_resp(conn, :no_content, "")
    end
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, restaurant} <- Restaurants.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end
end
