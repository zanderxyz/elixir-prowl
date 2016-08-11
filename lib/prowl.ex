defmodule Prowl do
  @moduledoc """
  Elixir application for sending notifications to Prowl (https://www.prowlapp.com/).
  """
  use GenServer
  alias HTTPoison.Response

  @name __MODULE__
  @base_url "https://api.prowlapp.com/publicapi"

  def start do
    GenServer.start(@name, :ok, [name: @name])
  end

  def init(:ok) do
    HTTPoison.start
  end

  @doc """
  Sends a notification to the API with the parameters given.
  Responses will come in one of the following forms:

    `{:ok, api_calls_remaining}`

    `{:error, {error_code, error_message}}`
  """
  def notify(application, event, description, priority \\ 0, url \\ "") do
    message = %{application: application,
                event: event,
                description: description,
                priority: priority,
                url: url}
    GenServer.call(@name, {:add, message})
  end

  def handle_call({:add, message}, _from, state) do
    message
    |> Map.put(:apikey, Application.get_env(:prowl, :apikey))
    |> URI.encode_query
    |> send_notification
    |> read_response
    |> send_reply(state)
  end

  defp send_notification(query) do
    {:ok, response} = HTTPoison.post("#{@base_url}/add?#{query}","")
    response
  end

  defp read_response(%Response{status_code: 200, body: body}) do
    {:ok, get_remaining_queries(body)}
  end
  defp read_response(%Response{status_code: _, body: body}) do
    {:error, get_error(Floki.find(body, "error"))}
  end

  defp get_remaining_queries(body) do
    body
    |> Floki.find("success")
    |> Floki.attribute("remaining")
    |> List.first
    |> String.to_integer
  end

  defp get_error(body) do
    {get_error_number(body), get_error_message(body)}
  end

  defp get_error_number(body) do
    body
    |> Floki.attribute("code")
    |> List.first
    |> String.to_integer
  end

  defp get_error_message(body) do
    body
    |> Floki.text
  end

  defp send_reply(body, state) do
    {:reply, body, state}
  end
end
