Tiny websocket server which bounces all messages back to all connected clients.

	. ./virtualenv/bin/activate
	pip install -r requirements.txt
	./server.hy

Environment variable `BOUNCE_PORT` sets the server port.

### minimal test client

	var ws = new WebSocket("ws://localhost:8123/");
	ws.onopen = function() {
	  ws.send("Hello Mr. Server!");
	};
	ws.onmessage = function (e) { alert(e.data); };
	ws.onclose = function() { };
