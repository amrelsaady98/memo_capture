import 'package:floor/floor.dart';
import 'package:memo_capture/core/models/memory.dart';

@dao
abstract class MemoryDao {
  @insert
  Future<void> insertMemory(Memory memory);

  @Query('SELECT * FROM memory WHERE id = :id')
  Future<Memory?> getMemoryById(int id);

  @Query('SELECT last_insert_rowid()')
  Future<int?> getLastId();

  @Query('SELECT * FROM memory')
  Future<List<Memory>> getAllMemoryItems();

  @update
  Future<void> updateMemory(Memory memory);

      
  @Query(
      'SELECT * FROM memory JOIN memory_tags ON memory.id = memory_tags.memoryId WHERE memory_tags.tagId = :id')
  Future<List<Memory>> getMemoryByTag(int id);
}
