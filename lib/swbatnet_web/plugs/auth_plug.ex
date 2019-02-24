defmodule SwbatnetWeb.Plugs.Auth do
  import Plug.Conn
  alias SwbatnetWeb.User

  def init(default), do: default

  def call(%Plug.Conn{private: %{plug_session: %{"admin" => %User{}}}} = conn, _default) do
    conn
  end

  def call(conn, _default) do
    conn
    |> Phoenix.Controller.put_flash(:info, "You must be an admin to access that")
    |> Phoenix.Controller.redirect(to: "/")
  end


end
