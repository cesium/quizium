defmodule QuiziumWeb.QuestionLive.Index do
  @moduledoc false
  use QuiziumWeb, :live_view

  alias Quizium.Quiz
  alias Quizium.Quiz.Question

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :questions, list_questions())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Question")
    |> assign(:question, Quiz.get_question!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Question")
    |> assign(:question, %Question{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Questions")
    |> assign(:question, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    question = Quiz.get_question!(id)
    {:ok, _} = Quiz.delete_question(question)

    {:noreply, assign(socket, :questions, list_questions())}
  end

  defp list_questions do
    Quiz.list_questions()
  end
end
