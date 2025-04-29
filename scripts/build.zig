const std = @import("std");
const Builder = @import("std").build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable(.{
        .name = "zig_back",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = mode,
    });

    exe.linkSystemLibrary("mongoc");

    exe.setOutputDir(b.cacheRoot);

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep()); 
    run_cmd.step.dependOn(&exe); // Ensure we build before running

    const exe_install = b.addInstallStep(&exe);
    b.default_step.dependOn(&exe_install);

    const test_step = b.addTestStep(std.testing.running_tests);
    test_step.step.dependOn(&exe_install);
}