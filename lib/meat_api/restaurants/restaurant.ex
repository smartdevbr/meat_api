defmodule MeatApi.Restaurants.Restaurant do
  use Ecto.Schema
  use Arc.Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @derive {Phoenix.Param, key: :id}
  schema "restaurants" do
    field :description, :string
    # after finishing it is gonna be an image
    field :image, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, params \\ %{}) do
    restaurant
    |> cast(params, [:image, :name, :description])
    |> validate_required([:image, :name, :description], message: "You have to fill this field")
  end
end
