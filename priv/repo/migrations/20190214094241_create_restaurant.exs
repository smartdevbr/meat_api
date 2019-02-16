defmodule MeatApi.Repo.Migrations.CreateRestaurant do
  use Ecto.Migration

  def change do
    create table(:restaurants, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :name, :string
      add :image, :string
      add :description, :string

      timestamps()
    end
  end
end
