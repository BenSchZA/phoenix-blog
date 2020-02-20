defmodule App.Email do
  use Bamboo.Phoenix, view: AppWeb.EmailView

  def send_test_email(from_email_address, subject, message) do
    [email: to_email_address] = Application.fetch_env!(:app, :personal)
    new_email()
    |> to(to_email_address)
    |> from(from_email_address) # also needs to be a validated email
    |> subject(subject)
    |> text_body(message)
  end
end
