defmodule QuiziumWeb.QuestionLiveTest do
  use QuiziumWeb.ConnCase

  import Phoenix.LiveViewTest
  import Quizium.QuizFixtures

  @create_attrs %{
    answer_1: "some answer_1",
    answer_2: "some answer_2",
    answer_3: "some answer_3",
    answer_4: "some answer_4",
    question: "some question"
  }
  @update_attrs %{
    answer_1: "some updated answer_1",
    answer_2: "some updated answer_2",
    answer_3: "some updated answer_3",
    answer_4: "some updated answer_4",
    question: "some updated question"
  }
  @invalid_attrs %{answer_1: nil, answer_2: nil, answer_3: nil, answer_4: nil, question: nil}

  defp create_question(_) do
    question = question_fixture()
    %{question: question}
  end

  describe "Index" do
    setup [:create_question]

    test "lists all questions", %{conn: conn, question: question} do
      {:ok, _index_live, html} = live(conn, Routes.question_index_path(conn, :index))

      assert html =~ "Listing Questions"
      assert html =~ question.answer_1
    end

    test "saves new question", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.question_index_path(conn, :index))

      assert index_live |> element("a", "New Question") |> render_click() =~
               "New Question"

      assert_patch(index_live, Routes.question_index_path(conn, :new))

      assert index_live
             |> form("#question-form", question: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#question-form", question: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_index_path(conn, :index))

      assert html =~ "Question created successfully"
      assert html =~ "some answer_1"
    end

    test "updates question in listing", %{conn: conn, question: question} do
      {:ok, index_live, _html} = live(conn, Routes.question_index_path(conn, :index))

      assert index_live |> element("#question-#{question.id} a", "Edit") |> render_click() =~
               "Edit Question"

      assert_patch(index_live, Routes.question_index_path(conn, :edit, question))

      assert index_live
             |> form("#question-form", question: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#question-form", question: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_index_path(conn, :index))

      assert html =~ "Question updated successfully"
      assert html =~ "some updated answer_1"
    end

    test "deletes question in listing", %{conn: conn, question: question} do
      {:ok, index_live, _html} = live(conn, Routes.question_index_path(conn, :index))

      assert index_live |> element("#question-#{question.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#question-#{question.id}")
    end
  end

  describe "Show" do
    setup [:create_question]

    test "displays question", %{conn: conn, question: question} do
      {:ok, _show_live, html} = live(conn, Routes.question_show_path(conn, :show, question))

      assert html =~ "Show Question"
      assert html =~ question.answer_1
    end

    test "updates question within modal", %{conn: conn, question: question} do
      {:ok, show_live, _html} = live(conn, Routes.question_show_path(conn, :show, question))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Question"

      assert_patch(show_live, Routes.question_show_path(conn, :edit, question))

      assert show_live
             |> form("#question-form", question: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#question-form", question: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.question_show_path(conn, :show, question))

      assert html =~ "Question updated successfully"
      assert html =~ "some updated answer_1"
    end
  end
end
