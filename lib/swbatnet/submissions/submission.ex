defmodule Swbatnet.Submissions.Submission do
  use Ecto.Schema
  import Ecto.Changeset


  schema "submissions" do
    field :results, {:array, :map}
    belongs_to :review, Swbatnet.Reviews.Review

    timestamps()
  end

  def changeset(submission, attrs) do
    submission
    |> cast(attrs, [:results, :review_id])
    |> validate_required([:results, :review_id])
  end
end
