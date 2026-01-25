const std = @import("std");
const yuku = @import("yuku");

const js = yuku.js;

pub fn main() !void {
    var gpa = std.heap.DebugAllocator(.{}).init;
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        return error.MissingPath;
    }

    const path = args[1];

    const cwd = std.fs.cwd();
    const stat = try cwd.statFile(path);

    if (stat.kind == .directory) {
        try parseDirectory(allocator, path);
    } else {
        try parseFile(allocator, path);
    }
}

fn parseDirectory(allocator: std.mem.Allocator, dir_path: []const u8) !void {
    var dir = try std.fs.cwd().openDir(dir_path, .{ .iterate = true });
    defer dir.close();

    var iter = dir.iterate();
    while (try iter.next()) |entry| {
        const full_path = try std.fs.path.join(allocator, &[_][]const u8{ dir_path, entry.name });
        defer allocator.free(full_path);

        if (entry.kind == .directory) {
            try parseDirectory(allocator, full_path);
        } else if (entry.kind == .file) {
            parseFile(allocator, full_path) catch {};
        }
    }
}

fn parseFile(allocator: std.mem.Allocator, file_path: []const u8) !void {
    const file = try std.fs.cwd().openFile(file_path, .{});
    defer file.close();

    var buffer: [4096]u8 = undefined;
    var reader = file.reader(&buffer);
    const contents = try reader.interface.allocRemaining(allocator, std.Io.Limit.limited(10 * 1024 * 1024));
    defer allocator.free(contents);

    const tree = try js.parse(std.heap.page_allocator, contents, .{
        .lang = js.Lang.fromPath(file_path),
        .source_type = js.SourceType.fromPath(file_path)
    });

    defer tree.deinit();
}
