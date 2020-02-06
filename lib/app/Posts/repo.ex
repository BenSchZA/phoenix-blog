defmodule App.Posts.Repo do
  def start_link do
    Agent.start_link(&init/0, name: __MODULE__)
  end

  def init, do: App.Posts.Crawler.crawl

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

  # use GenServer

  # def start_link do
  #   GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  # end

  # def init(:ok) do
  #   posts = App.Posts.Crawler.crawl
  #   {:ok, posts}
  # end

  # def get_by_slug(slug) do
  #   GenServer.call(__MODULE__, {:get_by_slug, slug})
  # end

  # def list() do
  #   GenServer.call(__MODULE__, {:list})
  # end

  # def handle_call({:get_by_slug, slug}, _from, posts) do
  #   case Enum.find(posts, fn(x) -> x.slug == slug end) do
  #     nil -> {:reply, :not_found, posts}
  #     post -> {:reply, {:ok, post}, posts}
  #   end
  # end

  # def handle_call({:list}, _from, posts) do
  #   {:reply, {:ok, posts}, posts}
  # end
end
