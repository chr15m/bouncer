Tiny websocket server which bounces all messages back to all connected clients.

	. ./virtualenv/bin/activate
	pip install -r requirements.txt
	./server.hy

Environment variable:

 * `BOUNCE_PORT` sets the server port.
 * `BOUNCE_HOST` sets the IPs the server will listen on.

### minimal test client

	var ws = new WebSocket("ws://localhost:8123/");
	ws.onopen = function() {
	  ws.send("Hello server!");
	};
	ws.onmessage = console.log;
	ws.onclose = function() { console.log("closed"); };
