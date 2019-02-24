defmodule Swbatnet.Repo.Migrations.CreateReviews do
  use Ecto.Migration

  def up do
    create table("reviews") do
      add :name, :string
      add :assessments, :jsonb

      timestamps()
    end
  end

  def down do
    drop table("reviews")
  end
end
