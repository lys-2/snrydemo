defmodule HwWeb.PageController do
  use HwWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
