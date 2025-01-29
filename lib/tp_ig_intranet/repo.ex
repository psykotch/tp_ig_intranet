defmodule TpIgIntranet.Repo do
  use Ecto.Repo,
    otp_app: :tp_ig_intranet,
    adapter: Ecto.Adapters.Postgres
end
