import 'package:floor/floor.dart';

import '../../models/memory_tag.dart';

@dao
abstract class MemoryTagDao {
  @insert
  Future<void> insertMemoryTag(MemoryTag memoryTag);

  // Method for inserting multiple MemoryTags
  @insert
  Future<void> insertMemoryTags(List<MemoryTag> memoryTags);

  @Query('SELECT * FROM memory_tags WHERE memoryId = :memoryId')
  Future<List<MemoryTag>> findTagsForMemory(int memoryId);

  @delete
  Future<void> deleteMemoryTag(MemoryTag memoryTag);
}
