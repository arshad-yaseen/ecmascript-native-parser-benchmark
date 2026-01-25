const std = @import("std");
const yuku = @import("yuku");

const js = yuku.js;

pub fn main() !void {
    const allocator = std.heap.c_allocator;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const path = args[1];
    const contents = try std.fs.cwd().readFileAlloc(path, allocator, std.Io.Limit.limited(10 * 1024 * 1024));
    defer allocator.free(contents);

    const tree = try js.parse(std.heap.page_allocator, contents, .{
        .lang = js.Lang.fromPath(path),
        .source_type = js.SourceType.fromPath(path),
    });

    defer tree.deinit();
}
