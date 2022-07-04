defmodule QuiziumWeb.PageController do
  use QuiziumWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
