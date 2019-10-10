defmodule SwbatnetWeb.SubmissionController do
  use SwbatnetWeb, :controller

  def index(conn, %{"id" => review_id}) do
    review = Swbatnet.Reviews.find_with_submissions(review_id)

    render(conn, review: review)
  end

  def create(conn, %{"submission" => results, "id" => review_id}) do
    # I'm sure there is a more Elixir-y way to do this...
    %{"comment" => comment} = results
    results = Map.delete(results, "comment")

    {:ok, submission} =
      Swbatnet.Submissions.create(%{review_id: review_id, results: results, comment: comment})

    redirect conn, to: "/thanks"
  end
end

