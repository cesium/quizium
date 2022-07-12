defmodule QuiziumWeb.QuizLive.Index do
  @moduledoc false
  use QuiziumWeb, :live_view

  alias Quizium.Quiz.Question

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(Quizium.PubSub, "quiz")

    {:ok,
     socket
     |> assign(:question, nil)}
  end

  @impl true
  def handle_info({%Question{} = question, answers}, socket) do
    {:noreply,
     socket
     |> assign(:question, question)
     |> assign(:answers, answers)}
  end
end
