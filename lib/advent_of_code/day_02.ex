defmodule AdventOfCode.Day02 do
  @bag %{"red" => 12, "green" => 13, "blue" => 14}

  def part1(args), do: solve(args, &filter_possible_games/1)
  def part2(args), do: solve(args, &sum_minimum_cubes/1)

  defp solve(args, operation) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_game/1)
    |> operation.()
  end

  defp filter_possible_games(games) do
    games
    |> Stream.with_index(1)
    |> Stream.filter(fn {game, _} -> possible_game?(game) end)
    |> Stream.map(fn {_, index} -> index end)
    |> Enum.sum()
  end

  defp sum_minimum_cubes(games) do
    Enum.sum(for cubes <- games, do: Enum.product(Map.values(cubes)))
  end

  def possible_game?(cubes) do
    Enum.all?(cubes, fn {color, count} -> @bag[color] >= count end)
  end

  def parse_game(line) do
    ~r/^Game \d+: (.+)$/
    |> Regex.run(line, capture: :all_but_first)
    |> List.first()
    |> String.split("; ")
    |> Enum.map(&parse_cubes/1)
    |> max_cubes()
  end

  def max_cubes(cube_sets), do: Enum.reduce(cube_sets, %{}, &Map.merge(&2, &1, fn _, x, y -> max(x, y) end))

  def parse_cubes(cubes) do
    cubes
    |> String.split(", ")
    |> Map.new(fn cube ->
      [count, color] = String.split(cube, " ")
      {color, String.to_integer(count)}
    end)
  end
end
