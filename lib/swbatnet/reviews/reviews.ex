defmodule Swbatnet.Reviews do
  alias Swbatnet.Repo
  alias Swbatnet.Reviews.Review

  def find(id), do: Repo.get(Review, id)

  def create(assessments, repo_name, dir_number) do
    attrs = %{
      assessments: jsonify_assessments(assessments),
      name: create_name(repo_name, dir_number)
    }

    %Review{}
    |> Review.changeset(attrs)
    |> Repo.insert()
  end

  defp create_name(repo_name, dir_number) do
    name = String.split(repo_name, "/") |> List.last()
    "#{name}: #{dir_number}"
  end

  defp jsonify_assessments(assessments) do
    Enum.map(assessments, fn ({type, content}) ->
      %{
        "type" => Atom.to_string(type),
        "content" => content
      }
    end)
  end
end
