defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
    |> Enum.with_index(1)
    |> Enum.filter(&possible_game?/1)
    |> Enum.map(fn {_, index} -> index end)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_game/1)
    |> Enum.map(&minimum_cubes/1)
    |> Enum.sum()
  end

  def minimum_cubes(cubes) do
    cubes
    |> Map.values()
    |> Enum.product()
  end

  def possible_game?(tuple) do
    bag = %{"red" => 12, "green" => 13, "blue" => 14}

    {cubes, _index} = tuple

    cubes
    |> Enum.filter(fn {color, count} ->
      bag[color] >= count
    end)
    |> Enum.count() == 3
  end

  def parse_game(line) do
    Regex.run(~r/^Game \d+: (.+)$/, line, capture: :all_but_first)
    |> Enum.at(0)
    |> String.split("; ")
    |> Enum.map(&parse_cubes/1)
    |> max_cubes()
  end

  def max_cubes(cube_sets) do
    Enum.reduce(cube_sets, %{}, fn set, acc ->
      Map.merge(acc, set, fn _, x, y -> max(x, y) end)
    end)
  end

  def parse_cubes(cubes) do
    cubes
    |> String.split(", ")
    |> Enum.map(fn cube ->
      [count, color] = String.split(cube, " ")
      {color, String.to_integer(count)}
    end)
    |> Map.new()
  end
end
