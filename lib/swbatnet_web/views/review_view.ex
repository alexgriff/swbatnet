defmodule SwbatnetWeb.ReviewView do
  use SwbatnetWeb, :view

  def admin_signed_in?(conn) do
    case Plug.Conn.get_session(conn, "admin") do
      %SwbatnetWeb.User{} -> true
      _ -> false
    end
  end

  def assessment_options do
    Map.to_list(Swbatnet.Submissions.Values.assessment_values())
  end

  def option_background(num) do
    case num do
      "0" -> "bg-success"
      "1" -> "bg-info"
      "2" -> "bg-danger"
      _ -> "text-muted"
    end
  end


end
