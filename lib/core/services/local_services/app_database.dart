import 'dart:async';

import 'package:floor/floor.dart';
import 'package:memo_capture/core/models/memory_tag.dart';
import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/core/services/local_services/memory_dao.dart';
import 'package:memo_capture/core/services/local_services/memory_tag_dao.dart';
import 'package:memo_capture/core/services/local_services/tag_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:memo_capture/core/models/medium.dart';
import 'package:memo_capture/core/services/local_services/medium_dao.dart';

import '../../models/memory.dart';

part 'app_database.g.dart';

@Database(version: 2, entities: [MediumItem, TagItem, Memory, MemoryTag])
abstract class AppDatabase extends FloorDatabase {
  MeduimDao get meduimDao;
  TagDao get tagDoa;
  MemoryDao get memoryDao;
  MemoryTagDao get memoryTagDao;
}
