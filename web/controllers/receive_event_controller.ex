defmodule FictionalPartner.Web.Controllers.ReceiveEventController do
  use FictionalPartner.Web, :controller
  alias FictionalPartner.ReceiveEvent
  require Logger

  @spec reply(conn :: Plug.Conn.t, params :: map()) :: Plug.Conn.t
  def reply(conn, %{"partner_reply" => status_code}) do
    log_request_data(conn)

    conn
    |> ReceiveEvent.reply(status_code)
    |> send_resp
  end

  @spec ask_redirect(conn :: Plug.Conn.t, params :: map()) :: Plug.Conn.t
  def ask_redirect(conn, %{"partner_reply" => status_code}) do
    log_request_data(conn)
    location_url = conn.body_params["location"]

    conn
    |> ReceiveEvent.ask_redirect(status_code, location_url)
    |> send_resp
  end

  defp log_request_data(conn) do
    body = conn.body_params
    headers = conn.req_headers
    Logger.info ["Body was: ", inspect(body)]
    Logger.info ["Headers were: ", inspect(headers)]
  end
end
