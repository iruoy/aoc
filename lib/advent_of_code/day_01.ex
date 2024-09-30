defmodule AdventOfCode.Day01 do
  def part1(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&extract1/1)
    |> Enum.sum()
  end

  def part2(args) do
    args
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&extract2/1)
    |> Enum.sum()
  end

  def extract1(line) do
    [first | last] = Regex.run(~r/^\D*?(\d).*?(\d)?\D*$/, line, capture: :all_but_first)
    last = List.last([first | last])

    (first <> last)
    |> String.to_integer()
  end

  def extract2(line) do
    regex =
      ~r/^.*?(\d|one|two|three|four|five|six|seven|eight|nine)(?:.*(\d|one|two|three|four|five|six|seven|eight|nine))?.*?$/

    [first | last] = Regex.run(regex, line, capture: :all_but_first)
    last = List.last([first | last])

    (first <> last)
    |> replace()
    |> String.to_integer()
  end

  def replace(line) do
    number_map = %{
      "one" => "1",
      "two" => "2",
      "three" => "3",
      "four" => "4",
      "five" => "5",
      "six" => "6",
      "seven" => "7",
      "eight" => "8",
      "nine" => "9"
    }

    String.replace(line, Map.keys(number_map), &number_map[&1])
  end
end
