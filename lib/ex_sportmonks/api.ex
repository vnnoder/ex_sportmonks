defmodule ExSportmonks.Api do
  require Logger

  @base_url "https://soccer.sportmonks.com/api/v2.0"
  @access_token Application.get_env(:ex_sportmonks, :token)

  def get(path, query_opts \\ %{}) do
    query_opts = Map.merge(query_opts, %{api_token: @access_token})

    url = path |> build_url()

    HTTPoison.get(url, headers(), params: query_opts)
    |> handle_response()
  end

  def build_url(path) do
    if String.starts_with?(path, "/") do
      @base_url <> path
    else
      @base_url <> "/" <> path
    end
  end

  def headers() do
    ["Content-Type": "application/json"]
  end

  defp handle_response({:ok, %HTTPoison.Response{body: body, status_code: code}})
       when code in 200..299 do
    {:ok, Poison.decode!(body)}
  end

  defp handle_response({:error, %HTTPoison.Error{id: nil, reason: :timeout}}),
    do: {:error, reason: :timeout}

  defp handle_response({:error, %HTTPoison.Response{body: body, status_code: _}}) do
    Logger.error(inspect(body))
    {:error, Poison.decode(body)}
  end
end
