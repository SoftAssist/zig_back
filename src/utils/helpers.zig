// src/utils/helpers.zig

const std = @import("std");
const mongo = @import("../deps/mongo.zig");

pub fn connectToDatabase(uri: []const u8, dbName: []const u8) !*mongo.Database {
    const allocator = std.heap.page_allocator;

    // Creating a connection pool to the MongoDB server.
    var connection = try mongo.Connection.pool(allocator, uri);
    
    // Connect to the specified database.
    const database = try connection.getDatabase(dbName);
    
    return database;
}

pub fn logMessage(message: []const u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("INFO: {s}\n", .{message}) catch {
        // Handle the error gracefully.
        stderr.print("Failed to log message: {s}\n", .{message});
    };
}