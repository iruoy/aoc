defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    input = "1abc2\npqr3stu8vwx\na1b2c3d4e5f\ntreb7uchet"
    result = part1(input)

    assert result = 142
  end

  test "part2" do
    input =
      "two1nine\neightwothree\nabcone2threexyz\nxtwone3four\n4nineeightseven2\nzoneight234\n7pqrstsixteen"

    result = part2(input)

    assert result = 281
  end
end
