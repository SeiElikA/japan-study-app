import 'package:get/get.dart';
import 'package:japan_study_app/app/binding/daily_binding.dart';
import 'package:japan_study_app/app/binding/experience_biding.dart';
import 'package:japan_study_app/app/binding/gallery_binding.dart';
import 'package:japan_study_app/app/binding/work_binding.dart';
import 'package:japan_study_app/app/view/best_work_detail_page.dart';
import 'package:japan_study_app/app/view/daily_itinerary/daily_itinerary_detail_page.dart';
import 'package:japan_study_app/app/view/daily_itinerary/daily_itinerary_page.dart';
import 'package:japan_study_app/app/view/daily_itinerary/work_list_page.dart';
import 'package:japan_study_app/app/view/gallery/gallery_detail_page.dart';
import 'package:japan_study_app/app/view/gallery/gallery_page.dart';
import 'package:japan_study_app/app/view/main_page.dart';
import 'package:japan_study_app/app/view/student_experience_page.dart';
import 'package:japan_study_app/app/view/teacher_experience_page.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.mainPage,
      page: () => const MainPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.dailyItineraryPage,
      binding: DailyBinding(),
      page: () => const DailyItineraryPage(),
    ),
    GetPage(
      name: Routes.dailyItineraryDetailPage,
      page: () => const DailyItineraryDetailPage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.studentExperiencePage,
      binding: ExperienceBinding(),
      page: () => const StudentExperiencePage(),
    ),
    GetPage(
      transition: Transition.fade,
      name: Routes.teacherExperiencePage,
      binding: ExperienceBinding(),
      page: () => const TeacherExperiencePage()
    ),
    GetPage(
        transition: Transition.fade,
        name: Routes.galleryPage,
        binding: GalleryBinding(),
        page: () => const GalleryPage()
    ),
    GetPage(
        name: Routes.galleryDetailPage,
        page: () => const GalleryDetailPage()
    ),
    GetPage(
        name: Routes.workListPage,
        binding: WorkBinding(),
        page: () => const WorkListPage()
    ),
    GetPage(
        name: Routes.bestWorkDetailPage,
        page: () => const BestWorkDetailPage()
    )
  ];
}
