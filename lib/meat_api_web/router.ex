defmodule MeatApiWeb.Router do
  use MeatApiWeb, :router

  pipeline :api do
    # plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
  end

  scope "/", MeatApiWeb do
    pipe_through :api
    # options   "/", RestaurantsController, :options
    resources("/", RestaurantsController)
  end

  scope "/swagger" do
    forward "/", PhoenixSwagger.Plug.SwaggerUI,
      otp_app: :meat_api,
      swagger_file: "swagger.json",
      opts: [disable_validator: true]
  end

  def swagger_info do
    %{
      info: %{
        version: "1.0",
        title: "Restaurant api",
        host: "localhost:4000"
      }
    }
  end
end
