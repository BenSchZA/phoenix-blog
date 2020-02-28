defmodule AppWeb.ProjectController do
  use AppWeb, :controller

  def index(conn, _params) do
    {:ok, projects} = App.Projects.Repo.list()
    github_repos =  Enum.map([
      "pier",
      "molecule-alpha",
      "molecule-system-modelling",
      "mechatronics-engineering-thesis",
      "nix-shells",
      "wattie-whatsapp-bot"
    ], fn repo -> App.Github.Api.github_repo(repo) end)
    render conn, "index.html", projects: projects, github_repos: github_repos
  end

  def show(conn, %{"slug" => slug}) do
    case App.Projects.Repo.get_by_slug(slug) do
      {:ok, project} -> render conn, "show.html", project: project
      :not_found -> not_found(conn)
    end
  end

  def not_found(conn) do
    conn
    |> put_status(:not_found)
    |> render(App.ErrorView, "404.html")
  end
end
