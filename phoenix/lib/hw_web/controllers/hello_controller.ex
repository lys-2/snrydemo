defmodule HwWeb.HelloController do
    use HwWeb, :controller

    def world(conn, %{"name" => name}) do
        IO.puts("12312313123")
        render conn, "world.html", name: name
    end
        
end
    