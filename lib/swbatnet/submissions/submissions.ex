defmodule Swbatnet.Submissions do
  alias Swbatnet.Repo
  alias Swbatnet.Submissions.Submission

  def all(id), do: Repo.get(Submission, id)

  def create(attrs) do
    %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
  end

end
