# Flutter Easy Template

Simple zero-dependencies State Management.

## 🏋 Motivation

State management can be hard in Flutter as well as in all other UI frameworks. Some prefer Flux, Bloc, Provider, Riverpod, you name it. While Flutter also comes with it's own state. Why don't we use it? Regardless how good they are, third party libraries as a basic building block for your application always comes with disadvantages:

- ♨️ Some state management frameworks might fit better than others for your project, but in the end there will always be overhead
- 🎓 You need to learn something new -> Onboarding new developers becomes harder
- 🏗️ It adds (sometimes unnecessary) complexity to your project
- 🙅 You rely on a third party developer who can stop developing their project at any time
- 🚫 ... or add breaking changes which will force you to a huge refactoring

## 💡 Idea

Use only native Flutter patterns to create a **Model-View-Viewmodel** state management template. We will use:

- StatefulWidget
- ChangeNotifier
- InheritedWidget
- Dart Extensions
- An easy to understand project structure

What we won't cover:

- Persistent storage (You decide if you like [Hive](https://pub.dev/packages/hive), [SQFlite](https://pub.dev/packages/sqflite) or [Isar](https://pub.dev/packages/isar))
- Routing (While the template comes with basic Navigator 1 routing)

And what will be the outcome?

- 🌱 Longer lasting code as you only rely on Flutter itself
- 💆 Less migrations to other state management frameworks
- 🌤️ Lightweight code which is easy to understand for all Flutter developers
- 🎆 You will finally be free from the *"Latest fancy framework, why haven't you already migrated yet?"*

### 🏛️ Architecture

```
┌────────────────────────────────────────────────────────────────┐
│                                                                │
│   Page                                                         │
│                                                                │
│   ┌────────────────────┐          ┌─────────────────────┐      │
│   │                    │          │                     │      │
│   │ View               │          │  Controller         │      │
│   │                    ◄──────────┤                     │      │
│   │ (StatelessWidget)  │          │  (StatefulWidget)   │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    ├──────────►                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   │                    │          │                     │      │
│   └────────────────────┘          └─────────────────────┘      │
│                                                                │
└──────────────────────────────┬─────────────────────────────────┘
                               │
                               │
                               │
┌──────────────────────────────▼─────────────────────────────────┐
│                                                                │
│   AppState ViewModel                                           │
│                                                                │
│   (InheritedWidget)                                            │
│                                                                │
└──────────────────────────────┬─────────────────────────────────┘
                               │
                               │
                               │
┌──────────────────────────────▼─────────────────────────────────┐
│                                                                │
│   AppStorage                                                   │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

### ✂️ Split View and Controller

Your app consists of multiple pages which are widgets of course. Those pages can have their own state which is created when the user navigates to this page and dismissed when the user leaves the page. As this state alone can become very huge we do a **View-Controller** split on this level. For this we create a StatefulWidget for the **controller**, without any UI. The build method will just call a StatelessWidget, which is the **view**.

```dart
class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => InfoController();
}

class InfoController extends State<InfoPage> {
  bool infoClickedOnce = false;
  void onInfoTab() {
    setState((){
        infoClickedOnce = true;
    });
    showAboutDialog(
        context: context,
        applicationName: AppConstants.applicationName,
    );
  }

  @override
  Widget build(BuildContext context) => InfoView(this);
}
```

InfoView is a StatelessWidget with gets the controller as it's only parameter:

```dart
class InfoView extends StatelessWidget {
  final InfoController controller;
  const InfoView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L10n.of(context)!.helloWorld),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Info'),
            leading: const Icon(Icons.info_outlined),
            onTap: controller.onInfoTab,
          ),
        ],
      ),
    );
  }
}

```

This way we can maintain the UI separated from the controller logic.

### 👁️ App State

Some state can not be defined in the scope of a page but in the scope of the whole app. For this we use InheritedWidget and ChangeNotifier. While the Provider package is very famous for this approach, using InheritedWidgets directly is so easy that we can do it easily by ourself. First of all we define the AppState as an InheritedWidget:

```dart
class AppState extends InheritedWidget {
  final AppStorage _appStorage;

  AppState({
    required AppStorage storage,
    required super.child,
    super.key,
  }) : _appStorage = storage;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppState>()!;

  /// Example state value using a ValueNotifier.
  final ValueNotifier<int> counter = ValueNotifier(0);
}
```

This widget represents the ViewModel of your application and is accessible everywhere via `AppState.of(context)`. The AppState holds a couple of ValueNotifier and can be extended with **actions**. It is also connected to the persistent `AppStorage`.

When we have defined our AppState, we add it to the builder method of our MaterialApp:

```dart
class AppWidget extends StatelessWidget {
  final AppStorage storage;
  const AppWidget({required this.storage, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.applicationName,
      initialRoute: '/',
      onGenerateRoute: AppRoutes.onGenerateRoute,
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      builder: (_, child) => AppState(
        storage: storage,
        child: child ?? Container(),
      ),
    );
  }
}

```

Depending on your choice for persistent data storage, the AppStorage may need to load some data before the app can operate. This can be done very fast in the main method.

### 🎡 Actions

The AppState can be extended with **Actions** which are just Dart extensions. We place them in separated files for a better overview:

```dart
extension CounterActions on AppState {
  void increaseCounter() {
    counter.value = counter.value + 1;
  }
}
```

Just import this action and call it directly from your views. You can use ValueListenableBuilder to access the AppState in a reactive way:

```dart
class HomeView extends StatelessWidget {
  final HomeController controller;
  const HomeView(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.applicationName),
      ),
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: AppState.of(context).counter,
          builder: (context, value, _) => Text(value.toString()),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: AppState.of(context).increaseCounter,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

### 📝 Some Notes

The AppState and the AppStorage does not know the underlying UI. Therefore the actions can be tested easily in unit tests. There is no native way for persistent data storing. Instead of hardcoding one solution like Hive you might consider writing an API for your AppStorage with just one implementation with possible migrations kept in mind.

Routing can also be hard. For most apps Navigator 1 might be good enough. Navigator 2 can be too complex but there are a lot of different packages out there. I have switched between them a lot but this is less pain as you don't need to think about migration here.