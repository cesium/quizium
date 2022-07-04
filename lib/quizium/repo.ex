defmodule Quizium.Repo do
  use Ecto.Repo,
    otp_app: :quizium,
    adapter: Ecto.Adapters.SQLite3
end
