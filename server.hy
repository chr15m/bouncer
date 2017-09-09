(import
  [SimpleWebSocketServer [SimpleWebSocketServer WebSocket]]
  [os [environ]])

(let [clients []]
  (defclass bounce [WebSocket]
    (defn handleMessage [self]
      (print "<- message:" self.data)
      (for [c clients]
        (.sendMessage c self.data)))
    (defn handleConnected [self]
      (print "-> connected:" self.address)
      (.append clients self))
    (defn handleClose [self]
      (print "-> closed:" self.address)
      (.remove clients self)))
  (let [server (SimpleWebSocketServer "" (.get environ "BOUNCE_PORT" 8123) bounce)]
    (print "== starting server ==")
    (.serveforever server)))
