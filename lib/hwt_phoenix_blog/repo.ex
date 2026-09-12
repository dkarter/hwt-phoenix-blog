defmodule HwtPhoenixBlog.Repo do
  use Ecto.Repo,
    otp_app: :hwt_phoenix_blog,
    adapter: Ecto.Adapters.Postgres
end
