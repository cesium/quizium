defmodule Quizium.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string

      timestamps()
    end
  end
end
