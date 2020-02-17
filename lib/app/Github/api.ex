defmodule App.Github.Api do
  use Memoize

  @spec avatar_url :: String.t()
  defmemo avatar_url(), expires_in: 5* 60 * 1000 do
    [handle: handle, username: _username, access_token: access_token] = Application.fetch_env!(:app, :github)
    client = Tentacat.Client.new(%{access_token: access_token})
    {200, data, _response} = Tentacat.Users.find(client, handle)
    data["avatar_url"]
  end

  @spec github_repo(binary) :: %{
          description: any,
          language: any,
          license: any,
          name: binary,
          stars: any,
          url: any
        }
  defmemo github_repo(name), expires_in: 5 * 60 * 1000 do
    [handle: handle, username: _username, access_token: access_token] = Application.fetch_env!(:app, :github)
    client = Tentacat.Client.new(%{access_token: access_token})
    {200, data, _response} = Tentacat.Repositories.repo_get(client, handle, name)
    %{
      name: name,
      description: get_in(data, ["description"]),
      url: get_in(data, ["svn_url"]),
      stars: get_in(data, ["stargazers_count"]),
      language: get_in(data, ["language"]),
      license: get_in(data, ["license", "spdx_id"]),
    }
  end
end
