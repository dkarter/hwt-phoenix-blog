defmodule HwtPhoenixBlog.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @words_per_minute 200

  schema "posts" do
    field :title, :string
    field :body, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :body])
    |> validate_required([:title, :body])
  end

  def reading_time_minutes(%__MODULE__{body: body}) do
    body
    |> String.split()
    |> length()
    |> max(1)
    |> then(&div(&1 + @words_per_minute - 1, @words_per_minute))
  end
end
