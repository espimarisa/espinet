import http.server
import socketserver
import os


PORT = 6969


class MyHttpRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header("Access-Control-Allow-Origin", "*")
        super().end_headers()


os.chdir(".")
handler_object = MyHttpRequestHandler
with socketserver.TCPServer(("", PORT), handler_object) as httpd:
    print(f"Serving at port {PORT}")
    print("Server is running. Press Ctrl+C to stop the server.")
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    print("Server stopped.")
    httpd.server_close()
    print("Server closed.")
