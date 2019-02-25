defmodule SwbatnetWeb.SubmissionController do
  use SwbatnetWeb, :controller

  def index(conn, %{"id" => review_id}) do
    review = Swbatnet.Reviews.find_with_submissions(review_id)

    render(conn, review: review)
  end

  def create(conn, %{"submission" => results, "id" => review_id}) do
    {:ok, submission} =
      Swbatnet.Submissions.create(%{review_id: review_id, results: results})

    redirect conn, to: "/thanks"
  end
end
