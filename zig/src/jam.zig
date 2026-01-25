const std = @import("std");
const jam = @import("jam");

const Parser = jam.Parser;

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    const path = args[1];
    const contents = try std.fs.cwd().readFileAlloc(path, allocator, std.Io.Limit.limited(10 * 1024 * 1024));
    defer allocator.free(contents);

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    const arena_allocator = arena.allocator();

    var parser = try Parser.init(arena_allocator, contents, .{ .source_type = .module });
    defer parser.deinit();

    var result = try parser.parse();
    defer result.deinit();
}
