defmodule AppWeb.EmailController do
  use AppWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end

  def create(conn, %{"email" => %{"email_from" => email_from, "message" => message}, "g-recaptcha-response" => recaptcha_response}) do
    case Recaptcha.verify(recaptcha_response) do
      {:ok, _response} ->
        App.Email.send_test_email(email_from, "Phoenix contact form", message)
        |> App.Mailer.deliver_later()

        conn
        |> put_flash(:info, "Email Sent")
        |> redirect(to: Routes.email_path(conn, :index))
      {:error, _errors} ->
        conn
        |> put_flash(:error, "reCAPTCHA Failed")
        |> redirect(to: Routes.email_path(conn, :index))
    end
  end
end
