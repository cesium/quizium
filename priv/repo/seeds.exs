# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Quizium.Repo.insert!(%Quizium.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Quizium.Quiz.Question
alias Quizium.Repo

[
  %Question{
    question: "The minimum RAM requirement for installing Windows XP is",
    correct_answer: "64 MB",
    answer_0: "32 MB",
    answer_1: "256 MB",
    answer_2: "128 MB"
  }
]
|> Enum.each(&Repo.insert!/1)
