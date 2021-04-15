defmodule ReposWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :repos

  alias Plug.Conn
  alias ReposWeb.Auth.Guardian, as: AuthGuardian

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
  plug :refresh_token

  defp refresh_token(%Conn{private: %{guardian_default_token: token}} = conn, _options) do
    {:ok, _old_stuff, {new_token, _claims}} = AuthGuardian.refresh(token)

    put_resp_header(conn, "x-token-refresh", new_token)
  end
end
