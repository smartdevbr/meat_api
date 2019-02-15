defmodule MeatApi.Factory do
  alias MeatApi.Restaurants.Restaurant

  def create(Restaurant) do
    %Restaurant{
      id: UUID.uuid4(),
      name: "Burguer house",
      description: "The best place to eat hamburguer in the world",
      image: "xpto"
    }
  end

  @doc """
  Creates an instance of the given Ecto Schema module type with the supplies attributes.
  ## Examples
  restaurant = insert(MeatApi.Restaurants.Restaurant, name: "abc")
  """
  @spec create(module, Enum.t()) :: map
  def create(schema, attributes) do
    schema
    |> create()
    |> struct(attributes)
  end

  @doc """
  Inserts a new instance of the given Ecto schema module into the Repo
  ## Examples
  restaurant = insert(MeatApi.Restaurants.Restaurant, name: "abc")
  """
  @spec insert(module, Enum.t()) :: map
  def insert(schema, attributes \\ []) do
    MeatApi.Repo.insert!(create(schema, attributes))
  end
end
