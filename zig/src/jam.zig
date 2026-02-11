const std = @import("std");
const jam = @import("jam");

const Parser = jam.Parser;
const source = @embedFile("source");

pub fn main(init: std.process.Init) !void {
    const allocator = init.arena.allocator();

    var parser = try Parser.init(allocator, source, .{ .source_type = .module });
    defer parser.deinit();

    var result = try parser.parse();
    defer result.deinit();
}
