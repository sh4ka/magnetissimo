defmodule Magnetissimo.PageController do
  use Magnetissimo.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def landing(conn, _params) do
    conn = put_layout conn, false
    render conn, "landing.html"
  end
end
