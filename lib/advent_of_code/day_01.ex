defmodule AdventOfCode.Day01 do
  @digit_words ~w(one two three four five six seven eight nine)
  @digit_map Map.new(Enum.zip(@digit_words ++ ~w(1 2 3 4 5 6 7 8 9), Stream.cycle(1..9)))

  def part1(args), do: process(args, ~r/(\d)/)
  def part2(args), do: process(args, ~r/(?=(\d|one|two|three|four|five|six|seven|eight|nine))/)

  defp process(args, regex) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&extract_number(&1, regex))
    |> Enum.sum()
  end

  defp extract_number(line, regex) do
    digits =
      regex
      |> Regex.scan(line, capture: :all_but_first)
      |> List.flatten()
      |> Enum.map(&word_to_digit/1)

    first = Enum.at(digits, 0)
    last = Enum.at(digits, -1, first)

    String.to_integer("#{first}#{last}")
  end

  defp word_to_digit(word), do: Map.get(@digit_map, word, word)
end
