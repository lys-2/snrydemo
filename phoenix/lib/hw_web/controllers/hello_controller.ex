defmodule HwWeb.HelloController do
    use HwWeb, :controller

    def world(conn, %{"name" => name}) do
        render conn, "world.html", name: name
    end
        
end
    