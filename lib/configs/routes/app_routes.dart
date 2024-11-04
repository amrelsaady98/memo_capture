import 'package:get/route_manager.dart';
import 'package:memo_capture/views/add_memo/add_memory_page.dart';
import 'package:memo_capture/views/add_memo/add_memory_bindings.dart';
import 'package:memo_capture/views/home/home_bindings.dart';
import 'package:memo_capture/views/home/home_page.dart';
import 'package:memo_capture/views/main/main_bindings.dart';
import 'package:memo_capture/views/main/main_page.dart';
import 'package:memo_capture/views/memo_details/memo_details_bindings.dart';
import 'package:memo_capture/views/memo_details/memo_details_page.dart';
import 'package:memo_capture/views/search/search_bindings.dart';
import 'package:memo_capture/views/search/search_page.dart';
import 'package:memo_capture/views/splash/splash_binding.dart';
import 'package:memo_capture/views/splash/splash_page.dart';

class AppRoutes {
  static const String SPLASH_PAGE = '/splash';
  static const String MAIN_PAGE = '/main';
  static const String HOME_PAGE = '/home';
  static const String SEARCH_PAGE = '/search';
  static const String MEMORY_DETAILS = '/memory-details';
  static const String ADD_MEMORY_PAGE = '/add-memory';
  static const String SETTINGS = '/settings';

  static final List<GetPage> GET_PAGES = [
    GetPage(
      name: SPLASH_PAGE,
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: MAIN_PAGE,
      page: () => const MainPage(),
      binding: MainBindings(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 2000),
    ),
    GetPage(
      name: HOME_PAGE,
      page: () => const HomePage(),
      binding: HomeBindings(),
    ),
    // GetPage(
    //   name: MEMORY_DETAILS,
    //   page: () => const MemoDetailsPage(),
    //   binding: MemoDetailsBindings(memoId: 0),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: ADD_MEMORY_PAGE,
      page: () => const AddMemoryPage(),
      binding: AddMemoryBindings(),
    ),
    // GetPage(
    //   name: SEARCH_PAGE,
    //   page: () => SearchPage(),
    //   binding: SearchBindings(),
    // ),
  ];
}
