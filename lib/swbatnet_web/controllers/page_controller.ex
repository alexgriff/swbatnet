defmodule SwbatnetWeb.PageController do
  use SwbatnetWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def unauthorized(conn, _params) do
    render conn, "unauthorized.html"
  end
end
