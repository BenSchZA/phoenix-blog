defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, posts} = App.Posts.Repo.list()
    github_repos =  Enum.map([
      "pier",
      "molecule-alpha",
      "molecule-system-modelling",
      "mechatronics-engineering-thesis",
      "nix-shells",
      "wattie-whatsapp-bot"
    ], fn repo -> App.Github.Api.github_repo(repo) end)
    render conn, "index.html", posts: posts, github_repos: github_repos
  end
end
