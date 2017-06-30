defmodule FictionalPartner.ReceiveEvent do
  import Plug.Conn

  @type url :: binary()
  @type status_code :: 100..599

  @spec reply(conn :: Plug.Conn.t, status_code :: status_code()) :: reply :: Plug.Conn.t
  def reply(conn, status_code) do
    parsed_status_code = String.to_integer(status_code)

    resp(conn, parsed_status_code, "")
  end

  @spec ask_redirect(conn :: Plug.Conn.t, status_code :: status_code(), location_url :: url()) :: Plug.Conn.t
  def ask_redirect(conn, status_code, location_url) do
    parsed_status_code = String.to_integer(status_code)

    conn
    |> resp(parsed_status_code, "")
    |> put_resp_header("location", location_url)
  end
end
