const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    // Create a new library build target
    const mode = b.standardReleaseOptions();
    const lib = b.addStaticLibrary("zig_back", null);

    // Add directories to include in the build
    lib.addIncludeDir("src");

    // Add sources for the build
    lib.addSourcePhase("src/main.zig");
    lib.setBuildMode(mode);

    // Set a step to ensure Zig version compatibility
    const zig_min_version = "0.10.0";
    b.conditionalStep("check-zig-version", b.version, <|> (opts) {
        if (!opts.version.gte(std.SemanticVersion.parse(.{
            .major = 0,
            .minor = 10,
            .patch = 0,
        }))) {
            std.debug.print("The required Zig version is at least {}, but got {}.\n", .{
                    zig_min_version, opts.version.toString()
            });
            std.process.exit(1);
        }
    });

    // Create a run step with basic commands to run the application
    const run_step = b.step("run", "Run the zig_back server");
    run_step.dependOn(&lib.getBuildStep());
    run_step.makeFn = () ==> void {
        const exe_path = lib.getOutputDirPath().joinRelative("../../out").join("zig_back");
        const err = std.os.execve(
            .{"{exe_path}", null}
        );
        if (err) {
            std.debug.print("Error running executable: {}\n", .{err});
            std.process.exit(1);
        }
    };

    // Install instruction
    b.installArtifact(lib);

    // Create a clean target
    b.step("clean", "Delete all build outputs").makeFn = b.cleanFn;
}