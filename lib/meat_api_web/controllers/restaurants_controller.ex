defmodule MeatApiWeb.RestaurantsController do
  use MeatApiWeb, :controller

  alias MeatApiWeb.ErrorView
  alias MeatApi.Restaurants
  alias MeatApi.Restaurants.Restaurant
  alias Plug.Conn

  def index(conn, _params),
    do: render(conn, "index.json", restaurants: Restaurants.list_restaurants())

  def show(conn, %{"id" => id}) do
    with restaurant = %Restaurant{} <- Restaurants.get_restaurant!(id) do
      render(conn, "show.json", restaurant: restaurant)
    else
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", error: "Not found")
    end
  end

  def create(conn, params) do
    with {:ok, restaurant} <- Restaurants.create_restaurant(params) do
      conn
      |> Conn.put_status(201)
      |> render("show.json", restaurant: restaurant)
    else
      {:error, %{errors: errors}} ->
        conn
        |> put_status(422)
        |> render(ErrorView, "422.json", %{errors: errors})
    end
  end

  def delete(conn, %{"id" => id}) do
    with restaurant = %Restaurant{} <- Restaurants.get_restaurant!(id) do
      Restaurants.delete_restaurant(restaurant)

      conn
      |> Conn.put_status(204)
      |> Conn.send_resp(:no_content, "")
    else
      nil ->
        conn
        |> put_status(404)
        |> render(ErrorView, "404.json", error: "Not found")
    end
  end

  def update(conn, params) do
    # There is no update! 
    # I will add the code in future but not in this tutorial
  end
end
