defmodule MeatApiWeb.Router do
  use MeatApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", MeatApiWeb do
    pipe_through :api
    resources("/", RestaurantsController)
  end
end
