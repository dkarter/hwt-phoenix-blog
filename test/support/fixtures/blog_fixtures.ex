defmodule HwtPhoenixBlog.BlogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `HwtPhoenixBlog.Blog` context.
  """

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        body: "some body",
        title: "some title"
      })
      |> HwtPhoenixBlog.Blog.create_post()

    post
  end
end
