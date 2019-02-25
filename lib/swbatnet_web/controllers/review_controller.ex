defmodule SwbatnetWeb.ReviewController do
  use SwbatnetWeb, :controller

  def new(conn, _params) do
    render conn, "new.html"
  end

  def create(conn, %{"review" => review_params}) do
    {:ok, review} =
      Swbatnet.GithubClient.fetch_swbat_file(review_params)
      |> Swbatnet.Parser.parse
      |> Swbatnet.Reviews.create(review_params["repository_url"], review_params["dir_number"])

    redirect conn, to: "/reviews/#{review.id}"
  end

  def show(conn, %{"id" => id}) do
    review = Swbatnet.Reviews.find(id)

    render conn, "show.html", review: review
  end

end
