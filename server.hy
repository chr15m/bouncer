#!/usr/bin/env hy
(import
  [os]
  [sys]
  ;[sqlite3]
  [signal [signal SIGPIPE SIG_DFL]]
  [functools [partial]]
  [websocket_server [WebsocketServer]]
  [os [environ]])

; https://stackoverflow.com/questions/492483/setting-the-correct-encoding-when-piping-stdout-in-python
(reload sys)
(sys.setdefaultencoding "utf8")

; https://stackoverflow.com/a/16865106/2131094
(signal SIGPIPE SIG_DFL)

; prevent buffering
(setv sys.stdout (os.fdopen (sys.stdout.fileno) "w" 0))

(defn handle-connect [clients client server]
  (print "-> connected:" (.get (or client {}) "address" "?")))

(defn handle-disconnect [clients client server]
  (print "-> disconnected:" (.get (or client {}) "address" "?")))

(defn handle-message [clients client server message]
  (print "<- message:" (.get (or client {}) "address" "?") message)
  (server.send_message_to_all message))

(let [clients []]
  (let [server (WebsocketServer (.get environ "BOUNCE_PORT" 8123) (.get environ "BOUNCE_HOST" "0.0.0.0"))]
    (server.set_fn_new_client (partial handle-connect clients))
    (server.set_fn_client_left (partial handle-disconnect clients))
    (server.set_fn_message_received (partial handle-message clients))
    (print "--- Starting ---")
    (server.run_forever)))
