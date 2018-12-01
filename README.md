# ExSportmonks

**Elixir Client for Soccer Sportmonks API 2.0 at https://www.sportmonks.com/products/soccer/docs/2.0**

## Installation

The package can be installed by adding `ex_sportmonks` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_sportmonks, "~> 0.1.0"}
  ]
end
```

## API Key

Register for an API key and add it to the environment variable
```
export SPORT_MONK_TOKEN="your api key here"
```

## Usage

All endpoints in https://www.sportmonks.com/products/soccer/docs/2.0 are supported.

### Get leagues from sportmonks:

```elixir
ExSportmonks.leagues()
```

### Get first 100 leagues with country from sportmonks:

```elixir
ExSportmonks.leagues(%{include: "country", page: 1})
```

For more information, please check [the API](https://github.com/vnnoder/ex_sportmonks/blob/master/lib/ex_sportmonks.ex)

