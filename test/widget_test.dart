import 'package:flutter_easy_template/model/app_storage.dart';
import 'package:flutter_easy_template/widgets/app_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Initialize the app', (WidgetTester tester) async {
    final storage = await AppStorage.init();
    await tester.pumpWidget(AppWidget(storage: storage));
  });
}
