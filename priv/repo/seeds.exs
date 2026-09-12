alias HwtPhoenixBlog.Blog

unless Enum.any?(Blog.list_posts(), &(&1.title == "Welcome to this worktree")) do
  {:ok, _post} =
    Blog.create_post(%{
      title: "Welcome to this worktree",
      body: "This post lives in the database assigned to this checkout by hwt."
    })
end
