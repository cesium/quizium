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
        question: "some question"
      })
      |> Quizium.Quiz.create_question()

    question
  end
end
