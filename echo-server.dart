main() {
    var socket = new ServerSocket("0.0.0.0", 9090, 10);
    socket.setConnectionHandler(function() {
        var client  = socket.accept()
        var buffer  = new List<int>(1024);
        
        client.setDataHandler(function() {
            int read = client.readList(buffer, 0, 1024);
            client.writeList(buffer, 0, read);
        });
    });
}
