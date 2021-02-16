defmodule App.Github.Api do

  def avatar_url() do
    Cachex.fetch(:github, "avatar_url", fn() ->
      IO.puts "Refreshing cache"
      Cachex.expire(:github, "avatar_url", :timer.minutes(5))
      [handle: handle, username: _username, access_token: access_token] = Application.fetch_env!(:app, :github)
      client = Tentacat.Client.new(%{access_token: access_token})
      case Tentacat.Users.find(client, handle) do
        {200, data, _response} ->
          {:commit, data["avatar_url"]}
        _ ->
          {:ignore, nil}
      end
    end)
    |> case do
      {:error, _} -> nil
      {_, nil} -> {:error, :not_found}
      {success, result} when success in [:ok, :loaded, :commit] -> result
    end
  end

  def github_repo(name) do
    Cachex.fetch(:github, "BenSchZA/" <> name, fn() ->
      IO.puts "Refreshing cache"
      Cachex.expire(:github, "BenSchZA/" <> name, :timer.minutes(5))
      [handle: handle, username: _username, access_token: access_token] = Application.fetch_env!(:app, :github)
      client = Tentacat.Client.new(%{access_token: access_token})
      case Tentacat.Repositories.repo_get(client, handle, name) do
        {200, data, _response} ->
          {:commit, %{
            name: name,
            description: get_in(data, ["description"]),
            url: get_in(data, ["svn_url"]),
            stars: get_in(data, ["stargazers_count"]),
            language: get_in(data, ["language"]),
            license: get_in(data, ["license", "spdx_id"]),
          }}
        _ -> {:ignore, nil}
      end
    end)
    |> case do
      {:error, _} -> nil
      {_, nil} -> {:error, :not_found}
      {success, result} when success in [:ok, :loaded, :commit] -> result
    end
  end
end
