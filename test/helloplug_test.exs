defmodule HelloplugTest do
  use ExUnit.Case
  use Plug.Test

  alias Router
  @content "<html><body>Hello!</body></html>"
  @mimetype "text/html"

  @opts Router.init([])

  test "returns welcome" do
    conn =
      conn(:get, "/", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
  end

  test "returns uploaded" do
    conn =
      conn(:post, "/upload", "content=#{@content}&mimetype=#{@mimetype}")
        |> put_req_header("content-type", "application/x-www-form-urlencoded")
        |> Router.call(@opts)

     assert conn.state == :sent
     assert conn.status == 201
  end

  test "returns 404" do
    conn = conn(:get, "/missing", "")
      |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 404
  end

  test "upload error" do
    assert_raise(Plug.VerifyRequest.IncompleteRequestError, fn() -> conn(:post, "/upload", "")
      |> put_req_header("content-type", "application/x-www-form-urlencoded")
      |> Router.call(@opts) end)
  end


end
