// import 'package:hive/hive.dart';

/// Holds a persistent storage of the data model for your app. Is visible for
/// the ViewModel but not for the view.
class AppStorage {
  // Define your persistent storage here. Hive box example:
  // final box = Box<String, String>();

  const AppStorage._(/*this.box*/);

  static Future<AppStorage> init() async {
    // Hive.initFlutter();
    // final box = Hive.openBox('my_box');
    return const AppStorage._(/*box*/);
  }
}
