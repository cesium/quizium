defmodule Quizium.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :question, :string
      add :correct_answer, :string
      add :answer_0, :string
      add :answer_1, :string
      add :answer_2, :string

      timestamps()
    end
  end
end
