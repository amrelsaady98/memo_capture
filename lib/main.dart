import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:memo_capture/configs/routes/app_routes.dart';
import 'package:memo_capture/core/services/local_services/app_database.dart';
import 'package:memo_capture/views/initial_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database_debug.db').build();
  Get.put(database);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH_PAGE,
      getPages: AppRoutes.GET_PAGES,
      initialBinding: InitialBindings(),
    );
  }
}
