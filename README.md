# Prowl

Elixir application for sending notifications to [Prowl](https://www.prowlapp.com/)

## Installation

The package can be installed by following these steps:

  1. Add prowl to your list of dependencies in `mix.exs`:

        def deps do
          [{:prowl, "~> 0.0.1"}]
        end

  2. Set your API key in your `config.exs`:

        config :prowl, apikey: "your api key"

  3. Ensure prowl is started before your application:

        def application do
          [applications: [:prowl]]
        end

## Example

    Prowl.notify("App", "Event", "Description")

Sends a notification with the app/event/description specified.

    Prowl.notify("App", "Event", "Description", priority)

Priority can range from -2 to 2 (default 0).

    Prowl.notify("App", "Event", "Description", priority, url)

An optional URL can be provided for the Prowl app to use to trigger a redirect.

[Full API Documentation](https://www.prowlapp.com/api.php)
