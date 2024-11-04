import 'package:memo_capture/core/models/tag.dart';
import 'package:memo_capture/core/services/local_services/tag_dao.dart';

class TagProvider {
  const TagProvider(this._tagDao);
  final TagDao _tagDao;

  Future<void> addTagItem(TagItem tagItem) async {
    await _tagDao.insertTagItem(tagItem);
  }

  Future<List<TagItem>> getAllTagItems() async {
    try {
      return await _tagDao.getAllTagItems();
    } catch (e) {
      throw e.toString();
    }
  }

  //TODO: Get memory tags
  Future<List<TagItem>> getMemoryTags(int id) async {
    try {
      return await _tagDao.getMemoryTags(id);
    } catch (e) {
      throw e.toString();
    }
  }
}
