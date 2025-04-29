const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();
    
    const exe = b.addExecutable("zig_back", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    
    // Add dependency paths or libraries if needed
    exe.linkSystemLibrary("ssl");
    exe.linkSystemLibrary("crypto");
    exe.addSystemLibraryPath("lib");

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());

    // If MongoDB C driver is used, make sure to instruct Zig to find it
    // Uncomment and set the path if MongoDB C driver is installed in a custom location
    // exe.addIncludeDir("/usr/local/include");
    // exe.addLibPath("/usr/local/lib");

    exe.install();
}