import 'package:memo_capture/core/models/memory.dart';
import 'package:memo_capture/core/models/memory_tag.dart';
import 'package:memo_capture/core/services/local_services/memory_dao.dart';

import '../services/local_services/memory_tag_dao.dart';

class MemoryProvider {
  MemoryProvider(this._memoryDao, this._memoryTagDao);
  final MemoryDao _memoryDao;
  final MemoryTagDao _memoryTagDao;

  Future<int?> addMediumItem(Memory memoryItem) async {
    await _memoryDao.insertMemory(memoryItem);
    int? lastMemoryId = await _memoryDao.getLastId();
    return lastMemoryId;
  }

  // Inserts multiple tags for a specific memory
  Future<void> addTagsToMemory(int memoryId, List<int> tagIds) async {
    List<MemoryTag> memoryTags = tagIds.map((tagId) {
      return MemoryTag(memoryId: memoryId, tagId: tagId);
    }).toList();

    await _memoryTagDao.insertMemoryTags(memoryTags);
  }

  Future<List<Memory>> getAllMemoryItems() async {
    try {
      return await _memoryDao.getAllMemoryItems();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Memory?> getMemoryById(int id) async {
    try{
      return await _memoryDao.getMemoryById(id);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int?> getLastmemoryId() async {
    return _memoryDao.getLastId();
  }

  Future<List<Memory>> getMemoryByTag(int tagId) async {
    try {
      return await _memoryDao.getMemoryByTag(tagId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<MemoryTag>> getMemoryTags(int memoryId) async {
    try {
      return await _memoryTagDao.findTagsForMemory(memoryId);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateMemory(Memory memory) async {
    try {
      await _memoryDao.updateMemory(memory); // Save changes to the database
    } catch (e) {
      throw Exception('Failed to update favorite status: $e');
    }
  }
}
