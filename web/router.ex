defmodule FictionalPartner.Router do
  use FictionalPartner.Web, :router
  alias FictionalPartner.Web.Controllers.{
    ReceiveEventController
  }

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :public do
    plug :accepts, ["json"]
  end

  scope "/api", FictionalPartner do
    pipe_through :api
  end

  scope "/" do
    pipe_through :public

    post "/receive_event/reply/:partner_reply", ReceiveEventController, :reply
    post "/receive_event/reply/:partner_reply/ask_redirect", ReceiveEventController, :ask_redirect

    post "/receive_event/block/:time_blocked", ReceiveEventController, :block
  end
end
