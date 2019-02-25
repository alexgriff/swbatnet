defmodule SwbatnetWeb.PageController do
  use SwbatnetWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def unauthorized(conn, _params) do
    render conn, "unauthorized.html"
  end

  def thanks(conn, _params) do
    render(conn, "thanks.html")
  end
end
