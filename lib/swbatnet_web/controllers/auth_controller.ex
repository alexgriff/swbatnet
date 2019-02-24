defmodule SwbatnetWeb.AuthController do
  use SwbatnetWeb, :controller
  alias SwbatnetWeb.User
  plug Ueberauth

  def callback(conn, _params) do
    %{
      assigns: %{
        ueberauth_auth: %{
          credentials: %{token: token},
          info: %{
            nickname: username,
            image: image
          }
        }
      }
    } = conn

    case Swbatnet.GithubClient.is_org_admin(token) do
      {:ok, _role} ->
        user = %User{username: username, image: image, token: token}
        conn = put_session(conn, :admin, user)
        redirect conn, to: "/admin/reviews/new"
      _err ->
        redirect conn, to: "/unauthorized"
    end
  end

end
