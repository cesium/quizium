defmodule Quizium.Quiz.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string

    # the right answer
    field :answer_1, :string
    field :answer_2, :string
    field :answer_3, :string
    field :answer_4, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :answer_1, :answer_2, :answer_3, :answer_4])
    |> validate_required([:question, :answer_1, :answer_2, :answer_3, :answer_4])
  end
end
