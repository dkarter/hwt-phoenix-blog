defmodule HwtPhoenixBlogWeb.HomePageTest do
  use HwtPhoenixBlogWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    assert html_response(conn, 200) =~ "Listing Posts"
  end
end
