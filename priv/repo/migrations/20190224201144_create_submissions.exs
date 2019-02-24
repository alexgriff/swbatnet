defmodule Swbatnet.Repo.Migrations.CreateSubmissions do
  use Ecto.Migration

  def change do
    create table("submissions") do
      add :results, :jsonb
      add :review_id, references(:reviews, on_delete: :nothing)
      
      timestamps()
    end
  end
end
