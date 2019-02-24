defmodule Swbatnet.GithubClient do
  @org_name "learn-co-students"
  @default_filename "LEARNING_GOALS.md"

  def is_org_admin(token) do
    case get_role(token) do
      "admin" ->
        {:ok, "admin"}
      _non_admin ->
        {:err, "nope"}
    end
  end

  def fetch_swbat_file(%{"repository_url" => repo_url, "dir_number" => dir_number, "filename" => filename}) do
    get_repo(repo_url)
    |> get_directory(dir_number)
    |> get_file(swbat_file(filename))
  end

  # Use default filename if none is given
  defp swbat_file(""), do: @default_filename
  defp swbat_file(filename), do: filename

  # API  Endpoints
  defp api_membership_url do
    "https://api.github.com/user/memberships/orgs"
  end

  defp api_repo_url do
    "https://api.github.com/repos"
  end

  defp api_contents_url(url) do
    Regex.replace(~r/\{\+path\}/, url, "")
  end

  defp api_contents_url(url, filename) do
    url <> "/" <> filename
  end

  # API requests
  defp get_role(token) do
    {:ok, %{body: body}} = HTTPoison.get(
      api_membership_url() <> "/" <> @org_name,
      %{Authorization: "Bearer #{token}"}
    )

    body
    |> Poison.decode!
    |> Map.get("role")
  end

  defp get_repo(repo_url) do
    {:ok, %{body: body}} = HTTPoison.get(api_repo_url() <> "/" <> repo_url)

    body
    |> Poison.decode!
  end

  defp get_directory(%{"contents_url" => contents_url}, dir_number) do
    url = api_contents_url(contents_url)
    {:ok, %{body: body}} = HTTPoison.get(url)

    name = body
    |> Poison.decode!
    |> Enum.find(fn (%{"name" => name}) -> String.starts_with?(name, dir_number) end)
    |> Map.get("name")

    url <> name
  end

  defp get_file(dir_url, filename) do
    {:ok, %{body: body}} = HTTPoison.get(api_contents_url(dir_url, filename))

    body
    |> Poison.decode!
    |> Map.get("content")
  end
end
