defmodule ExSportmonksTest do
  use ExUnit.Case
  doctest ExSportmonks

  test "Api returns data" do
    countries = ExSportmonks.countries()
    assert countries
  end
end
