
import 'package:luvutest/services/authentication_service.dart';
import 'package:get_it/get_it.dart';
import 'package:luvutest/services/cloud_storage_service.dart';


import 'package:luvutest/services/navigation_service.dart';
import 'package:luvutest/services/dialog_service.dart';
import 'package:luvutest/utils/image_selector.dart';


GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ImageSelector());
  locator.registerLazySingleton(() => CloudStorageService());


}
