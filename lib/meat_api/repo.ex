defmodule MeatApi.Repo do
  use Ecto.Repo,
    otp_app: :meat_api,
    adapter: Ecto.Adapters.Postgres
end
