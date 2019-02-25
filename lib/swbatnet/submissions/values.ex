defmodule Swbatnet.Submissions.Values do
  def assessment_values do
    %{
      "0" => "I get it / I feel comfortable / Yes. / I can do this",
      "1" => "I ~sort of~ get it / I'll need more practice, but I think I can do this with time / Starting to wrap my head around this & I know the things I have to do to improve on this",
      "2" => "I'm lost / I don't have any idea how to do this / I don't know what this means / This concept did not click",
      "3" => "I'm not sure we covered this topic at all / I don't get the question"
    }
  end
end
