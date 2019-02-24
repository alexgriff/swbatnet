defmodule Swbatnet.Reviews.Review do
  use Ecto.Schema
  import Ecto.Changeset


  schema "reviews" do
    field :name, :string
    field :assessments, {:array, :map}
    has_many :submissions, Swbatnet.Submissions.Submission

    timestamps()
  end

  def changeset(review, attrs) do
    review
    |> cast(attrs, [:name, :assessments])
    |> validate_required([:name, :assessments])
  end
end
