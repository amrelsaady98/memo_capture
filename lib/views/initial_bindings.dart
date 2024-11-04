import 'package:floor/floor.dart';
import 'package:get/get.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() async {
    final migration1to2 = Migration(1, 2, (database) async {});
    final database = await $FloorAppDatabase
        .databaseBuilder('app_database_debug.db')
        .build();
    Get.put(database);
  }
}
