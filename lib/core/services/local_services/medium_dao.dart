import 'package:floor/floor.dart';
import 'package:memo_capture/core/models/medium.dart';

@dao
abstract class MeduimDao {
  @Query('SELECT * FROM medium')
  Future<List<MediumItem>> getAllMediumItems();

  @insert
  Future<void> insertMediumItem(MediumItem mediumItem);
}
