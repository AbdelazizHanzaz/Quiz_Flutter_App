import 'dart:io';
import 'package:hive/hive.dart';

class FileAdapter extends TypeAdapter<File> {
  @override
  final typeId = 100;

  @override
  File read(BinaryReader reader) {
    final filePath = reader.readString();
    return File(filePath);
  }

  @override
  void write(BinaryWriter writer, File obj) {
    writer.writeString(obj.path);
  }
}
