defmodule Quizium.Quiz.Question do
  @moduledoc """
  A Question is the unit of a Quiz.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :question, :string

    # the right answer
    field :correct_answer, :string
    field :answer_0, :string
    field :answer_1, :string
    field :answer_2, :string

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:question, :correct_answer, :answer_0, :answer_1, :answer_2])
    |> validate_required([:question, :correct_answer, :answer_0, :answer_1, :answer_2])
  end
end
