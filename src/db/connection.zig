const std = @import("std");
const mongo = @import("../deps/mongo.zig");

pub fn initMongoConnection() !mongo.Connection {
    const allocator = std.testing.allocator;
    const uri = try std.fs.cwd().openFile("mongo_uri.txt", .{});
    defer uri.close();

    var uriBuffer: [1024]u8 = undefined;
    const uriReadLen = try uri.reader().readUntilDelimiterOrEof(uriBuffer[0..], '\n');
    const uriString = uriBuffer[0..uriReadLen];

    var connection = try mongo.Connection.connect(allocator, uriString);
    std.debug.print("MongoDB connected successfully to: {}\n", .{uriString});

    return connection;
}

pub fn closeMongoConnection(connection: *mongo.Connection) void {
    std.debug.print("Closing MongoDB connection.\n", .{});
    connection.deinit();
}