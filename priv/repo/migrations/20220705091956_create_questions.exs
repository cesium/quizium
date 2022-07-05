defmodule Quizium.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :answer_1, :string
      add :answer_2, :string
      add :answer_3, :string
      add :answer_4, :string

      timestamps()
    end
  end
end
