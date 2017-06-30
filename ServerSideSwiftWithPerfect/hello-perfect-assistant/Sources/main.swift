import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let server = HTTPServer()
server.serverPort = 8080

var routes = Routes()

routes.add(method: .get, uri: "/") { (request, response) in
	response.setBody(string: "Hello, Perfect!")
	.completed()
}

// Content-Type: text/html; charset=utf-8
routes.add(method: .get, uri: "/home") {
	$1.setHeader(.contentType, value: "text/html; charset=utf-8")
	$1.setBody(string: "<html><head><title>HMOE</title></head><body>Hello, Perfect!<a pref=\"https://google.com\">this is a link</a></body></html>")
	.completed()
}

server.addRoutes(routes)

do {
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
