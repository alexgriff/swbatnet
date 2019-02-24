defmodule Swbatnet.Parser do
  @swbat_indicators ['*', '-']

  def parse(encoded_file) do
    decode(encoded_file)
    |> find_swbats
    |> build_assessment_list([])
    |> strip_leading_chars
  end

  # takes the @swbat_indicators list ["*", "-"]
  # and returns a string with each char escaped "\*\-"
  # use: to be interploated into a regex
  defp swbat_indicators_for_regex do
    Enum.map(@swbat_indicators, fn i -> "\\#{i}" end) |> Enum.join("")
  end

  defp decode(encoded_file) do
    {:ok, content} = Base.decode64(encoded_file, ignore: :whitespace)
    content
  end

  defp find_swbats(contents) do
    String.split(contents, "\n")
    |> Enum.filter(fn line ->
      String.match?(line, ~r/^\s*[#{swbat_indicators_for_regex()}]/)
    end)
  end

  defp build_assessment_list([current], results) do
    results ++ [{:assessment, current}]
  end

  defp build_assessment_list([current | rest ], results) do
    current_indicator_index = find_index(current)
    next_indicator_index = find_index(List.first(rest))

    swbat =
      case next_indicator_index > current_indicator_index do
        true ->
          {:info, current}
        false ->
          {:assessment, current}
      end

    build_assessment_list(rest, results ++ [swbat])
  end

  defp find_index(swbat) do
    [{index, _length}] = Regex.run(
      ~r/[#{swbat_indicators_for_regex()}]/,
      swbat,
      return: :index
    )

    index
  end

  defp strip_leading_chars(swbats) do
    Enum.map(swbats, fn ({type, swbat}) ->
      { type, Regex.replace(~r/^\s*[#{swbat_indicators_for_regex()}]\s*/, swbat, "") }
    end)
  end
end
