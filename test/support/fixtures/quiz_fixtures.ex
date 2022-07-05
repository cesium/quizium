defmodule Quizium.QuizFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Quizium.Quiz` context.
  """

  @doc """
  Generate a question.
  """
  def question_fixture(attrs \\ %{}) do
    {:ok, question} =
      attrs
      |> Enum.into(%{
        answer_1: "some answer_1",
        answer_2: "some answer_2",
        answer_3: "some answer_3",
        answer_4: "some answer_4",
        question: "some question"
      })
      |> Quizium.Quiz.create_question()

    question
  end
end
