defmodule Quizium.QuizTest do
  use Quizium.DataCase

  alias Quizium.Quiz

  describe "questions" do
    alias Quizium.Quiz.Question

    import Quizium.QuizFixtures

    @invalid_attrs %{answer_1: nil, answer_2: nil, answer_3: nil, answer_4: nil, question: nil}

    test "list_questions/0 returns all questions" do
      question = question_fixture()
      assert Quiz.list_questions() == [question]
    end

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Quiz.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{
        answer_1: "some answer_1",
        answer_2: "some answer_2",
        answer_3: "some answer_3",
        answer_4: "some answer_4",
        question: "some question"
      }

      assert {:ok, %Question{} = question} = Quiz.create_question(valid_attrs)
      assert question.answer_1 == "some answer_1"
      assert question.answer_2 == "some answer_2"
      assert question.answer_3 == "some answer_3"
      assert question.answer_4 == "some answer_4"
      assert question.question == "some question"
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Quiz.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()

      update_attrs = %{
        answer_1: "some updated answer_1",
        answer_2: "some updated answer_2",
        answer_3: "some updated answer_3",
        answer_4: "some updated answer_4",
        question: "some updated question"
      }

      assert {:ok, %Question{} = question} = Quiz.update_question(question, update_attrs)
      assert question.answer_1 == "some updated answer_1"
      assert question.answer_2 == "some updated answer_2"
      assert question.answer_3 == "some updated answer_3"
      assert question.answer_4 == "some updated answer_4"
      assert question.question == "some updated question"
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Quiz.update_question(question, @invalid_attrs)
      assert question == Quiz.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Quiz.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Quiz.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Quiz.change_question(question)
    end
  end
end
