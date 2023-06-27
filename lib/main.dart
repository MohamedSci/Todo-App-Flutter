import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/Authentication/Logic/Auth_Api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Authentication/Logic/authScreenProvider.dart';
import 'package:todo_app/Authentication/Screens/Auth_main_page.dart';
import 'package:todo_app/Constants/colors.dart';
import 'package:todo_app/Constants/strings.dart';
import 'package:todo_app/Filtering/filter_controller/filter_controller.dart';
import 'package:todo_app/Notification/notification_services.dart';
import 'package:todo_app/TODO_List/controller/todo_controller.dart';
import 'package:todo_app/TODO_List/database_sqflite/database_provider.dart';
import 'package:todo_app/generalWidgets/custum_route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<AuthApi>(
      create: (BuildContext context) => AuthApi(),
    ),
    BlocProvider<AuthScreenProvider>(
      create: (BuildContext context) => AuthScreenProvider(),
    ),
    BlocProvider<DatabaseProvider>(
      create: (BuildContext context) => DatabaseProvider(),
    ),
    BlocProvider<ToDoController>(
      create: (BuildContext context) => ToDoController(),
    ),
    BlocProvider<FilterController>(
      create: (BuildContext context) => FilterController(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackColor,
        accentColor: kCardColor,
        bottomAppBarColor: kBarColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CustomPageTransitionBuilder(),
          TargetPlatform.iOS: CustomPageTransitionBuilder(),
        }),
      ),
      home: const AuthMainScreen(),
    );
  }
}
