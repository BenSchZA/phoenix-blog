defmodule App.Pages.Repo do
  def start_link(_arg) do
    Agent.start_link(&init/0, name: __MODULE__)
  end

  def init, do: App.Pages.Crawler.crawl

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
    Agent.get(__MODULE__, fn posts -> {:ok, posts} end)
  end

  def get_by_slug(slug) do
    Agent.get(__MODULE__, fn posts ->
      case Enum.find(posts, fn(x) -> x.slug == slug end) do
        nil -> :not_found
        post -> {:ok, post}
      end
    end)
  end
end
