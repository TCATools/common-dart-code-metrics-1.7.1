part of '../io.dart';

/// Represents the result of calling the POSIX [`stat`](http://manpages.ubuntu.com/manpages/xenial/man2/stat.2.html) function on a file system entity.
/// It is an immutable object, representing the snapshotted values returned by the `stat()` call.
class FileStat implements io.FileStat {
  /// Creates new file stats from the specified native [stats].
  FileStat._fromStats(io.FileStat stats, {this.gid = -1, this.uid = -1})
      : accessed = stats.accessed,
        changed = stats.changed,
        mode = stats.mode,
        modified = stats.modified,
        size = stats.size,
        type = stats.type;

  /// Calls the operating system's `stat()` function on the specified [path].
  ///
  /// Completes with a [FileStat] object containing the data returned by `stat()`.
  /// If the call fails, completes the future with a [FileStat] object with [type] set to `FileSystemEntityType.notFound` and the other fields invalid.
  static Future<FileStat> stat(String path) async {
    assert(path.isNotEmpty);

    final stats = await io.FileStat.stat(path);
    if (Finder.isWindows) return FileStat._fromStats(stats);

    final args = io.Platform.isMacOS
        ? ['-f', '%u:%g', '-L']
        : ['--dereference', '--format=%u:%g'];
    final result = await io.Process.run('stat', args..add(path));
    if (result.exitCode != 0) return FileStat._fromStats(stats);

    final parts = result.stdout.trim().split(':');
    return parts.length != 2
        ? FileStat._fromStats(stats)
        : FileStat._fromStats(stats,
            gid: int.tryParse(parts.last, radix: 10) ?? -1,
            uid: int.tryParse(parts.first, radix: 10) ?? -1);
  }

  /// Synchronously calls the operating system's `stat()` function on the specified [path].
  ///
  /// Returns a [FileStat] object containing the data returned by `stat()`.
  /// If the call fails, returns a [FileStat] object with [type] set to `FileSystemEntityType.notFound` and the other fields invalid.
  static FileStat statSync(String path) {
    // ignore: prefer_constructors_over_static_methods
    assert(path.isNotEmpty);

    final stats = io.FileStat.statSync(path);
    if (Finder.isWindows) return FileStat._fromStats(stats);

    final args = io.Platform.isMacOS
        ? ['-f', '%u:%g', '-L']
        : ['--dereference', '--format=%u:%g'];
    final result = io.Process.runSync('stat', [...args, path]);
    if (result.exitCode != 0) return FileStat._fromStats(stats);

    final parts = result.stdout.trim().split(':');
    return parts.length != 2
        ? FileStat._fromStats(stats)
        : FileStat._fromStats(stats,
            gid: int.tryParse(parts.last, radix: 10) ?? -1,
            uid: int.tryParse(parts.first, radix: 10) ?? -1);
  }

  /// The time of the last access to the data of the file system entity.
  /// On Windows platforms, this may have 1 day granularity, and be out of date by an hour.
  @override
  final DateTime accessed;

  /// The time of the last change to the data or metadata of the file system object.
  /// On Windows platforms, this is instead the file creation time.
  @override
  final DateTime changed;

  /// The numeric identity of the file's group, or `-1` if this information is not available.
  final int gid;

  /// The time of the last change to the data of the file system object.
  @override
  final DateTime modified;

  /// The mode of the file system entity. Permissions are encoded in the lower 16 bits of this number.
  @override
  final int mode;

  /// The total size, in bytes, of the file system entity.
  @override
  final int size;

  /// The type of the file system entity.
  /// If the call to `stat()` fails, the type of the returned entity is `FileSystemEntityType.notFound`.
  @override
  final io.FileSystemEntityType type;

  /// The numeric identity of the file's owner, or `-1` if this information is not available.
  final int uid;

  /// Returns the [mode] value as a human-readable string, in the format `"rwxrwxrwx"`,
  /// reflecting the user, group, and world permissions to read, write, and execute the file system entity,
  /// with `"-"` replacing the letter for missing permissions.
  ///
  /// Extra permission bits may be represented by prepending `"(suid)"`, `"(guid)"`, and/or `"(sticky)"` to the mode string.
  @override
  String modeString() {
    const codes = ['---', '--x', '-w-', '-wx', 'r--', 'r-x', 'rw-', 'rwx'];
    final permissions = mode & 0xFFF;
    return [
      if ((permissions & 0x800) != 0) '(suid) ',
      if ((permissions & 0x400) != 0) '(guid) ',
      if ((permissions & 0x200) != 0) '(sticky) ',
      codes[(permissions >> 6) & 0x7],
      codes[(permissions >> 3) & 0x7],
      codes[permissions & 0x7]
    ].join();
  }
}
