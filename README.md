# Prowl

Elixir application for sending notifications to [Prowl](https://www.prowlapp.com/)

## Installation

The package can be installed by following these steps:

1. Add prowl to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:prowl, "~> 0.0.1"}]
end
```

2. Set your API key in your `config.exs`:

```elixir
config :prowl, apikey: "your api key"
```

3. Ensure prowl is started before your application:

```elixir
def application do
  [applications: [:prowl]]
end
```

## Usage

```elixir
iex> Prowl.notify(application, event, description, priority \\ 0, url \\ "")
{:ok, 988}
```

Sends a notification with the app/event/description specified. Successful responses will come in the format above, where 988 is the number of api calls you have left (at the time of writing Prowl sets a limit of 1000 per hour).

The optional field priority can range from -2 to 2.

An optional URL can also be provided for the Prowl app to use to trigger a redirect.

## Errors

```elixir
iex> Prowl.notify(application, event, description, priority, url)
{:error, {error_code, error_message}}
```

If the API returns an error then the response will come in the format above. A list of possible error codes is given in the full API documentation.

[Full API Documentation](https://www.prowlapp.com/api.php)
