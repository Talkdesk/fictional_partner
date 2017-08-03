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

  def validate_signature(conn, %{"algorithm" => algorithm, "secret" => secret}) do
    signature = hd(Plug.Conn.get_req_header(conn, "x-hub-signature"))
    payload = Poison.encode!(conn.body_params)
    Logger.info ["PAYLOAD: ", inspect(payload)]
    Logger.info ["SIGNATURE: ", inspect(Plug.Conn.get_req_header(conn, "x-hub-signature"))]
    result = ReceiveEvent.validate_signature(String.to_atom(algorithm), secret, payload, signature)

    if result do
      resp(conn, 200, "")
    else
      resp(conn, 400, "")
    end
  end

  @spec ask_redirect(conn :: Plug.Conn.t, params :: map()) :: Plug.Conn.t
  def block(conn, %{"time_blocked" => time_blocked}) do
    log_request_data(conn)
    time_blocked
    |> String.to_integer
    |> :timer.sleep

    send_resp(conn, 200, "")
  end

  defp log_request_data(conn) do
    body = conn.body_params
    headers = conn.req_headers
    Logger.info ["Body was: ", inspect(body)]
    Logger.info ["Headers were: ", inspect(headers)]
  end
end
