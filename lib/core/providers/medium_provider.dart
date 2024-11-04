import 'package:memo_capture/core/models/medium.dart';
import 'package:memo_capture/core/services/local_services/medium_dao.dart';

class MediumProvider {
  MediumProvider(this._meduimDao);
  final MeduimDao _meduimDao;

  Future<void> addMediumItem(MediumItem mediumItem) async {
    await _meduimDao.insertMediumItem(mediumItem);
  }

  Future<List<MediumItem>> getAllMediumItems() async {
    try {
      return await _meduimDao.getAllMediumItems();
    } catch (e) {
      throw e.toString();
    }
  }
}
