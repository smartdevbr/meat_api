defmodule MeatApiWeb.RestaurantsControllerTest do
    use MeatApiWeb.ConnCase, async: true

    alias MeatApi.Restaurants
    alias MeatApi.Restaurants.Restaurant

    @create_attrs %{ name: "Burguer house", description: "The best place to eat hamburguer in the world", image: "xpto" }
    @update_attrs %{ name: "Burguer house updated"}
    @invalid_attrs %{ name: nil}

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
            conn = post(conn, Routes.restaurants_path(conn, :create), restaurant: @create_attrs)
            assert %{"id" => id} = json_response(conn, 201)["data"]

            IO.inspect json_response(conn, 201)["data"]
            conn = get(conn, Routes.restaurant_path(conn, :show, id))

            assert %{"id" => id, "name" => "Burguer house", "description" => "The best place to eat hamburguer in the world", "image" => "xpto"}
            = json_response(conn, 200)["data"]
        end
    end



end