import 'package:floor/floor.dart';
import 'package:memo_capture/core/models/medium.dart';
import 'package:memo_capture/core/models/tag.dart';

@dao
abstract class TagDao {
  @Query('SELECT * FROM tag')
  Future<List<TagItem>> getAllTagItems();

  @insert
  Future<void> insertTagItem(TagItem tagItem);

  @Query(
      'SELECT * FROM tag JOIN memory_tags ON tag.id = memory_tags.tagId WHERE memory_tags.memoryId = :id')
  Future<List<TagItem>> getMemoryTags(int id);
}
