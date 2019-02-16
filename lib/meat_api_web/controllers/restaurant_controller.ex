defmodule MeatApiWeb.RestaurantController do
  use MeatApiWeb, :controller
  use PhoenixSwagger

  alias MeatApi.Restaurants
  alias MeatApi.Restaurants.Restaurant

  action_fallback MeatApiWeb.FallbackController

  def swagger_definitions do
    %{
      Restaurant:
        swagger_schema do
          title("Restaurant")
          description("An restaurant that was recorded")

          properties do
            id(:string, "The Id of the restaurant")
            name(:string, "The name recorded", required: true)
            description(:string, "The description recorded", required: true)
            image(:string, "The image recorded", required: true)
          end

          example %{
            name: "Burguer house",
            description: "The best place to eat hamburguer in the world",
            image: "xpto"
          } 
        end,
      Restaurants:
        swagger_schema do
          title("Restaurants")
          description("All restaurants that have been recorded")
          type(:array)
          items(Schema.ref(:Restaurant))
        end,
      Error:
        swagger_schema do
          title("Errors")
          description("Error responses from the API")

          properties do
            error(:string, "The message of the error raised", required: true)
          end
        end
    }
  end

  swagger_path :index do
    get("/")
    summary("List all recorded restaurants")
    description("List all recorded restaurants")
    response(200, "Ok", Schema.ref(:Restaurants))
  end

  def index(conn, _params) do
    render(conn, "index.json", restaurants: Restaurants.list_restaurants())
  end

  swagger_path :show do
    get("/{id}")
    summary("Retrieve an restaurant")
    description("Retrieve an restaurant that you have recorded")

    parameters do
      id(:path, :string, "The id of the restaurant", required: true)
    end

    response(200, "Ok", Schema.ref(:Restaurant))
    response(404, "Not found", Schema.ref(:Error))
  end

  def show(conn, %{"id" => id}) do
        render(conn, "show.json", restaurant: Restaurants.get_restaurant!(id))
  end

  swagger_path :create do
    post("/")
    summary("Add a new restaurant")
    description("Record a new restaurant which has been completed")

    parameters do
      restaurant(:body, Schema.ref(:Restaurant), "Restaurant to record", required: true)
    end

    response(201, "Ok", Schema.ref(:Restaurant))
    response(422, "Unprocessable Entity", Schema.ref(:Error))
  end

  def create(conn, restaurant_params) do
    with {:ok, restaurant} <- Restaurants.create_restaurant(restaurant_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.restaurant_path(conn, :show, restaurant))
      |> render("show.json", restaurant: restaurant)
    end
  end

  swagger_path :delete do
    PhoenixSwagger.Path.delete("/{id}")
    summary("Delete Restaurant")
    description("Delete a restaurant by ID")
    parameter(:id, :path, :string, "User ID", required: true, example: "fdsf")
    response(203, "No Content - Deleted Successfully")
  end

  def delete(conn, %{"id" => id}) do
    with restaurant = %Restaurant{} <- Restaurants.get_restaurant!(id) do
      Restaurants.delete_restaurant(restaurant)
      send_resp(conn, :no_content, "")
    end
  end

  swagger_path :update do
    patch("/{id}")
    summary("Update an existing restaurant")
    description("Record changes to a completed restaurant")

    parameters do
      id(:path, :string, "The id of the restaurant", required: true)
      restaurant(:body, Schema.ref(:Restaurant), "The restaurant details to update")
    end

    response(201, "Ok", Schema.ref(:Restaurant))
    response(422, "Unprocessable Entity", Schema.ref(:Error))
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Restaurants.get_restaurant!(id)

    with {:ok, restaurant} <- Restaurants.update_restaurant(restaurant, restaurant_params) do
      render(conn, "show.json", restaurant: restaurant)
    end
  end
end
