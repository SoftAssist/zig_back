const std = @import("std");
const mongo = @import("mongodb");

const MongoDBClient = struct {
    allocator: *std.mem.Allocator,
    uri: []const u8,
    client: *mongo.Client = null,

    pub fn init(allocator: *std.mem.Allocator, uri: []const u8) !MongoDBClient {
        var instance = MongoDBClient{ .allocator = allocator, .uri = uri };
        try instance.connect();
        return instance;
    }

    fn connect(self: *MongoDBClient) !void {
        const client_or_error = mongo.connect(self.allocator, self.uri);
        if (client_or_error.error) |err| {
            std.debug.print("Failed to connect to MongoDB: {}\n", .{err});
            return err;
        } else |client| {
            self.client = client;
        }
    }

    pub fn close(self: *MongoDBClient) void {
        if (self.client) |client| {
            mongo.disconnect(self.allocator, client);
        }
    }

    pub fn exampleOperation(self: *MongoDBClient) !void {
        if (!self.client) {
            return error.NoClient;
        }
        // Example operation such as finding documents or inserting
        // var collection = self.client.getCollection("example");
        // Add logic to interact with MongoDB collection
    }

    pub fn deinit(self: *MongoDBClient) void {
        self.close();
    }
};

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    var dbClient = try MongoDBClient.init(allocator, "mongodb://localhost:27017");
    defer dbClient.deinit();

    // Example operation using the MongoDB client
    try dbClient.exampleOperation();

    std.debug.print("Successfully performed operations on MongoDB.\n", .{});
}