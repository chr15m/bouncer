Tiny websocket server which bounces all messages back to all connected clients.

	. ./virtualenv/bin/activate
	pip install -r requirements.txt
	./server.hy

Environment variable `BOUNCE_PORT` sets the server port.
