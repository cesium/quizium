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
        correct_answer: "some correct_answer",
        answer_0: "some answer_0",
        answer_1: "some answer_1",
        answer_2: "some answer_2",
        question: "some question"
      })
      |> Quizium.Quiz.create_question()

    question
  end
end
