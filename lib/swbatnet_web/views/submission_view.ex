defmodule SwbatnetWeb.SubmissionView do
  use SwbatnetWeb, :view

  def column_headers do
    Map.values(Swbatnet.Submissions.Values.assessment_values())
  end

  def rows(review) do
    # [["swbat1", 0, 3, 1, 2], ["swbat2", 2, 2, 1, 0], ...]
    submission_histogram(review)
    |> Enum.map(fn({k, v}) -> [k | Map.values(v)] end)
  end

  defp submission_histogram(review) do
    histogram = build_histogram(review)

    review.submissions
    |> Enum.flat_map(fn submission -> submission.results end)
    |> Enum.reduce(histogram, fn ({k, v}, acc) ->
      %{acc | k => %{acc[k] | v => acc[k][v] + 1}}
    end)
  end

  defp review_keys(review) do
    Swbatnet.Reviews.assessments_for(review)
  end

  defp build_histogram(review) do
    # %{
    #   "swbat1" => %{"0" => 0, "1" => 0, "2" => 0, ...},
    #   "swbat2" => %{"0" => 0, "1" => 0, "2" => 0, ...},
    #   ...
    # }

    keys = Map.keys(Swbatnet.Submissions.Values.assessment_values())

    review_keys(review)
    |> Enum.map(fn row ->
      {row, Enum.map(keys, fn k -> {k, 0} end) |> Map.new}
    end)
    |> Map.new
  end
end
