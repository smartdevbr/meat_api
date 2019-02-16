defmodule MeatApiWeb.RestaurantsControllerTest do
  use MeatApiWeb.ConnCase, async: true

  alias MeatApi.Restaurants
  alias MeatApi.Restaurants.Restaurant

  @create_attrs %{
    name: "Burguer house",
    description: "The best place to eat hamburguer in the world",
    image: "xpto"
  }
  @update_attrs %{name: "Burguer house updated"}
  @invalid_attrs %{name: nil}

  def fixture(:restaurant) do
    {:ok, restaurant} = Restaurants.create_restaurant(@create_attrs)
    restaurant
  end

  defp create_restaurant(_) do
    restaurant = fixture(:restaurant)
    {:ok, restaurant: restaurant}
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "list all restaurants", %{conn: conn} do
      conn = get(conn, Routes.restaurants_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create restaurant" do
    test "renders restaurant when data is valid", %{conn: conn} do
      conn = post(conn, Routes.restaurants_path(conn, :create), @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.restaurants_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "Burguer house",
               "description" => "The best place to eat hamburguer in the world",
               "image" => "xpto"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.restaurants_path(conn, :create), restaurant: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update restaurant" do
    setup [:create_restaurant]

    test "renders restaurant when data is valid", %{
      conn: conn,
      restaurant: %Restaurant{id: id} = restaurant
    } do
      conn =
        put(conn, Routes.restaurants_path(conn, :update, restaurant), restaurant: @update_attrs)

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.restaurants_path(conn, :show, id))

      assert %{
               "id" => id,
               "name" => "Burguer house updated"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, restaurant: restaurant} do
      conn =
        put(conn, Routes.restaurants_path(conn, :update, restaurant), restaurant: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete restaurant" do
    setup [:create_restaurant]

    test "deletes chosen test", %{conn: conn, restaurant: restaurant} do
      conn = delete(conn, Routes.restaurants_path(conn, :delete, restaurant))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.restaurants_path(conn, :show, restaurant))
      end
    end
  end
end
