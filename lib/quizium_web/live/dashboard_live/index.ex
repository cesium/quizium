defmodule QuiziumWeb.DashboardLive.Index do
  @moduledoc false
  use QuiziumWeb, :live_view

  alias Quizium.Quiz

  @impl true
  def mount(_params, _session, socket) do
    questions = Quiz.list_questions()

    {:ok,
     socket
     |> assign(:questions, questions)
     |> assign(:question, Enum.at(questions, 0))
     |> assign(:answers, [])}
  end

  @impl true
  def handle_event("back", _params, socket) do
    {question, answers} =
      Enum.at(socket.assigns.questions, socket.assigns.question.id - 2)
      |> broadcast()

    {:noreply,
     socket
     |> assign(:question, question)
     |> assign(:answers, answers)}
  end

  @impl true
  def handle_event("next", _params, socket) do
    {question, answers} =
      Enum.at(socket.assigns.questions, socket.assigns.question.id)
      |> broadcast()

    {:noreply,
     socket
     |> assign(:question, question)
     |> assign(:answers, answers)}
  end

  def broadcast(question) do
    answers =
      Enum.shuffle([
        question.correct_answer,
        question.answer_0,
        question.answer_1,
        question.answer_2
      ])

    Phoenix.PubSub.broadcast!(Quizium.PubSub, "quiz", {question, answers})
    {question, answers}
  end
end
