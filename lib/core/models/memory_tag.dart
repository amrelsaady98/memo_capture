import 'package:floor/floor.dart';

@Entity(tableName: 'memory_tags')
class MemoryTag {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int memoryId; // Foreign key to Memory
  final int tagId;    // Foreign key to TagItem

  MemoryTag({
    this.id,
    required this.memoryId,
    required this.tagId,
  });

    @override
  String toString() {
    return 'MemoryTag{id: $id, memoryId: $memoryId, tagId: $tagId}';
  }
  
}