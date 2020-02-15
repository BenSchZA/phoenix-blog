defmodule App.Projects.Repo do
  def start_link(_arg) do
    Agent.start_link(&init/0, name: __MODULE__)
  end

  def init, do: App.Projects.Crawler.crawl

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def list() do
    Agent.get(__MODULE__, fn projects -> {:ok, projects} end)
  end

  def get_by_slug(slug) do
    Agent.get(__MODULE__, fn projects ->
      case Enum.find(projects, fn(x) -> x.slug == slug end) do
        nil -> :not_found
        project -> {:ok, project}
      end
    end)
  end
end
