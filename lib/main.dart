import 'package:floor_database/floor/dao/PersonDao.dart';
import 'package:floor_database/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'database/database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dao = database.personDao;
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final PersonDao dao;
  const MyApp(this.dao, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Floor Database',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  HomePage(personDao: dao),
    );
  }
}
