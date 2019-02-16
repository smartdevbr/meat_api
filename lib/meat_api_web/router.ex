defmodule MeatApiWeb.Router do
  use MeatApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MeatApiWeb do
    pipe_through :api
    resources("/", RestaurantsController)
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI, otp_app: :meat_api, swagger_file: "swagger.json"
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Meat api"
      }
    }
  end

end
