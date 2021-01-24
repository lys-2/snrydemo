defmodule Hw.Repo do
  use Ecto.Repo,
    otp_app: :hw,
    adapter: Ecto.Adapters.Postgres
end
