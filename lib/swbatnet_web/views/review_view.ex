defmodule SwbatnetWeb.ReviewView do
  use SwbatnetWeb, :view

  def assessment_options do
    [
      {0, "I get it / I feel comfortable / Yes. / I can do this"},
      {1, "I ~sort of~ get it / I'll need more practice, but I think I can do this with time / Starting to wrap my head around this & I know the things I have to do to improve on this"},
      {2, "I'm lost / I don't have any idea how to do this / I don't know what this means / This concept did not click"},
      {3, "I'm not sure we covered this topic at all / I don't get the question"}
    ]
  end

  def option_background(num) do
    case num do
      0 -> "bg-success"
      1 -> "bg-info"
      2 -> "bg-danger"
      _ -> "text-muted"
    end
  end


end
