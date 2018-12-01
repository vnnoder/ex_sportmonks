defmodule ExSportmonks do
  alias ExSportmonks.Api

  use Timex

  def continents(options \\ %{}) do
    Api.get("/continents", options)
  end

  def continent(id, options \\ %{}) do
    Api.get("/continents/#{id}", options)
  end

  def countries(options \\ %{}) do
    Api.get("/countries", options)
  end

  def country(id, options \\ %{}) do
    Api.get("/countries/#{id}", options)
  end

  def leagues(options \\ %{}) do
    Api.get("/leagues", options)
  end

  def league(id, options \\ %{}) do
    Api.get("/leagues/#{id}", options)
  end

  def seasons(options \\ %{}) do
    Api.get("/seasons", options)
  end

  def season(id, options \\ %{}) do
    Api.get("/seasons/#{id}", options)
  end

  def fixture(id, options \\ %{}) do
    Api.get("/fixtures/#{id}", options)
  end

  @spec fixtures(List.t(), Map.t()) :: {:ok, any} | {:error, any}
  def fixtures(ids, options \\ %{}) do
    ids_param = Enum.join(ids, ",")
    Api.get("/fixtures/multi/#{ids_param}", options)
  end

  def fixtures_by_date(%Date{} = date, options \\ %{}) do
    with {:ok, date_str} <- format_date(date) do
      Api.get("/fixtures/date/#{date_str}", options)
    end
  end

  def fixtures_between(%Date{} = from, %Date{} = to, league_ids \\ [], options \\ %{}) do
    with {:ok, from_str} <- format_date(from),
         {:ok, to_str} <- format_date(to),
         leagues_param <- format_league_ids(league_ids) do
      if leagues_param do
        Api.get(
          "/fixtures/between/#{from_str}/#{to_str}",
          Map.merge(options, %{leagues: leagues_param})
        )
      else
        Api.get("/fixtures/between/#{from_str}/#{to_str}", options)
      end
    end
  end

  def fixtures_between_by_team(
        %Date{} = from,
        %Date{} = to,
        team_id,
        league_ids \\ [],
        options \\ %{}
      ) do
    with {:ok, from_str} <- format_date(from),
         {:ok, to_str} <- format_date(to),
         leagues_param <- format_league_ids(league_ids) do
      if leagues_param do
        Api.get(
          "/fixtures/between/#{from_str}/#{to_str}/#{team_id}",
          Map.merge(options, %{leagues: leagues_param})
        )
      else
        Api.get("/fixtures/between/#{from_str}/#{to_str}/#{team_id}", options)
      end
    end
  end

  def stages_by_season(season_id, options \\ %{}) do
    Api.get("/stages/season/#{season_id}", options)
  end

  def stages(id, options \\ %{}) do
    Api.get("/stages/#{id}", options)
  end

  def live_scores(league_ids \\ [], options \\ %{}) do
    leagues_param = format_league_ids(league_ids)

    if leagues_param do
      Api.get("/livescores", Map.merge(options, %{leagues: leagues_param}))
    else
      Api.get("/livescores", options)
    end
  end

  def live_scores_in_play(league_ids \\ [], options \\ %{}) do
    leagues_param = format_league_ids(league_ids)

    if leagues_param do
      Api.get("/livescores/now", Map.merge(options, %{leagues: leagues_param}))
    else
      Api.get("/livescores/now", options)
    end
  end

  def commentaries_by_fixture(fixture_id, options \\ %{}) do
    Api.get("/commentaries/fixture/#{fixture_id}", options)
  end

  def highlights(options \\ %{}) do
    Api.get("/highlights", options)
  end

  def head_2_head(team1_id, team2_id, options \\ %{}) do
    Api.get("/head2head/#{team1_id}/#{team2_id}", options)
  end

  def tv_stations_by_fixture(fixture_id, options \\ %{}) do
    Api.get("/tvstations/fixture/#{fixture_id}", options)
  end

  def standings_by_season(season_id, options \\ %{}) do
    Api.get("/standings/season/#{season_id}", options)
  end

  def team(id, options \\ %{}) do
    Api.get("/teams/#{id}", options)
  end

  def teams_by_season(season_id, options \\ %{}) do
    Api.get("/teams/season/#{season_id}", options)
  end

  def top_scorer_by_season(season_id, options \\ %{}) do
    Api.get("/topscorers/season/#{season_id}", options)
  end

  def aggregated_top_scorer_by_season(season_id, options \\ %{}) do
    Api.get("/topscorers/season/#{season_id}/aggregated", options)
  end

  def venue(id, options \\ %{}) do
    Api.get("/venues/#{id}", options)
  end

  def venues_by_season(season_id, options \\ %{}) do
    Api.get("/venues/season/#{season_id}", options)
  end

  def round(id) do
    Api.get("/rounds/#{id}")
  end

  def rounds_by_season(season_id, options \\ %{}) do
    Api.get("/rounds/season/#{season_id}", options)
  end

  defp format_date(%Date{} = date) do
    Timex.format(date, "%Y-%m-%d", :strftime)
  end

  defp format_league_ids([]), do: nil

  defp format_league_ids(league_ids) do
    Enum.join(league_ids, ",")
  end

  def odds_by_fixure_and_bookmaker(fixture_id, bookmaker_id, options \\ %{}) do
    Api.get("odds/fixture/#{fixture_id}/bookmaker/#{bookmaker_id}", options)
  end

  def odds_by_fixure(fixture_id, options \\ %{}) do
    Api.get("odds/fixture/#{fixture_id}", options)
  end

  def odds_by_fixure_and_market(fixture_id, market_id, options \\ %{}) do
    Api.get("odds/fixture/#{fixture_id}/market/#{market_id}", options)
  end

  def bookmakers(options \\ %{}) do
    Api.get("bookmakers", options)
  end

  def bookmaker(bookmaker_id, options \\ %{}) do
    Api.get("bookmakers/#{bookmaker_id}", options)
  end

  def markets(options \\ %{}) do
    Api.get("markets", options)
  end

  def market(market_id, options \\ %{}) do
    Api.get("markets/#{market_id}", options)
  end

  # notice that this api is for bet365 only
  def in_play_odds_by_fixure(fixture_id, options \\ %{}) do
    Api.get("odds/inplay/fixture/#{fixture_id}", options)
  end

  def player(player_id, options \\ %{}) do
    Api.get("players/#{player_id}", options)
  end

  def squad_by_season_and_team(season_id, team_id, options \\ %{}) do
    Api.get("squad/season/#{season_id}/team/#{team_id}", options)
  end

  def coach(coach_id, options \\ %{}) do
    Api.get("coaches/#{coach_id}", options)
  end

  def get_total_pages({:ok, data} = _response) do
    data["meta"]["pagination"]["total_pages"]
  end
end
