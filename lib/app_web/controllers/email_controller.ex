defmodule AppWeb.EmailController do
  use AppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def create(conn, %{"email" => %{"email_from" => email_from, "message" => message}}) do
    App.Email.send_test_email(email_from, "Phoenix contact form", message)
    |> App.Mailer.deliver_later()

    conn
    |> put_flash(:info, "Email Sent")
    |> redirect(to: Routes.email_path(conn, :index))
  end
end
