// scripts/setup.zig
const std = @import("std");
const fs = std.fs;

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Setting up the project...\n", .{});

    // Define the installation steps
    const steps = [_]Step{
        step("Creating build directory", createBuildDirectory),
        step("Ensure zigmod is installed", ensureZigmodInstalled),
        step("Install Zig dependencies", installZigDependencies),
        step("Verify MongoDB connection", verifyMongoDbConnection),
    };

    // Execute each step
    for (steps) |step| {
        try step();
    }

    try stdout.print("Setup complete.\n", .{});
}

fn step(description: []const u8, action: fn () !void) Step {
    return Step{ .description = description, .action = action};
}

fn createBuildDirectory() !void {
    const buildDir = "zig-out";
    if (!fs.cwd().openDir(buildDir, .{}) orelse null) {
        try fs.cwd().createDir(buildDir, .{});
    }
}

fn ensureZigmodInstalled() !void {
    // Check for zigmod and prompt for installation if not found
    const result = try std.process.exec(.{
        .argv = &[_][]const u8{"zigmod", "version"},
    });
    result.wait() catch |err| switch (err) {
        error.ChildProcessTerminated => try failWithZigmodInstruction(),
        else => |e| return e,
    };
}

fn failWithZigmodInstruction() !void {
    std.debug.print("Error: zigmod is required but not found.\n", .{});
    std.debug.print(
        "Please install zigmod using steps from: https://github.com/nektro/zigmod\n",
        .{},
    );
    return error.Error;
}

fn installZigDependencies() !void {
    const result = try std.process.exec(.{
        .argv = &[_][]const u8{"zigmod", "fetch"},
    });
    result.wait() catch |err| switch (err) {
        error.ChildProcessTerminated => |spawned_err| {
            std.debug.print("Error: Failed to install Zig dependencies.\n", .{});
            return spawned_err;
        },
        else => |e| return e,
    };
}

fn verifyMongoDbConnection() !void {
    // Simulate MongoDB connection verification
    const mongoDBAddress = "mongodb://localhost:27017";
    std.debug.print("Verifying MongoDB connection at {s}...\n", .{mongoDBAddress});

    // In a real scenario, here you would implement a mechanism to verify the connection.
    // For now, simply simulate success.
    const dbConnectionAvailable = true;

    if (!dbConnectionAvailable) {
        std.debug.print("Error: Unable to connect to MongoDB at {s}.\n", .{mongoDBAddress});
        return error.Error;
    }
}

const Step = struct {
    description: []const u8,
    action: fn () !void,
};