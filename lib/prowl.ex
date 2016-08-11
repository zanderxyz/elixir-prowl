defmodule Prowl do
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
    body
  end

  defp send_reply(body, state) do
    {:reply, body, state}
  end
end
