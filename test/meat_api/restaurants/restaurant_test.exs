defmodule MeatApi.RestaurantsTest do
  # I need to understand this
  use MeatApi.DataCase
  alias MeatApi.Restaurants

  describe "restaurants" do
    alias MeatApi.Restaurants.Restaurant

    @valid_attrs %{
      description: "some description",
      image: "simple image",
      name: "burguer amazing"
    }

    @update_attrs %{
      description: "update description",
      image: "update image",
      name: "update burguer"
    }

    @invalid_attrs %{description: nil, image: nil, name: nil}

    def restaurant_fixture(params \\ %{}) do
      {:ok, restaurant} =
        params
        |> Enum.into(@valid_attrs)
        |> Restaurants.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Restaurants.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Restaurants.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Restaurants.create_restaurant(@valid_attrs)
      assert restaurant.description == "some description"
      assert restaurant.image == "simple image"
      assert restaurant.name == "burguer amazing"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Restaurants.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()

      assert {:ok, %Restaurant{} = restaurant} =
               Restaurants.update_restaurant(restaurant, @update_attrs)

      assert restaurant.description == "update description"
      assert restaurant.image == "update image"
      assert restaurant.name == "update burguer"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Restaurants.update_restaurant(restaurant, @invalid_attrs)

      assert restaurant == Restaurants.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Restaurants.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Restaurants.get_restaurant!(restaurant.id) end
    end
  end
end
