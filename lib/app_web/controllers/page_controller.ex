defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = App.Posts.Repo.list()
    render conn, "index.html", posts: posts
  end
end
