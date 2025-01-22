import 'package:genrative_ai/core/repositories/api_services.dart';
import 'package:genrative_ai/core/viewmodel/chat_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
setUpLocator() {
  locator.registerLazySingleton(() => ChatViewModel());
  locator.registerLazySingleton(() => GoogleGenerativeServices());
}
