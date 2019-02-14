defmodule MeatApiWeb.Router do
  use MeatApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MeatApiWeb do
    pipe_through :api
  end
end
