import 'package:floor_database/floor/dao/PersonDao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'database/database.dart';
import 'floor/entity/Person.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final dao = database.personDao;
  runApp(MyApp(dao));
}

class MyApp extends StatelessWidget {
  final PersonDao dao;
  const MyApp(this.dao);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page',personDao: dao),
    );
  }
}

class MyHomePage extends StatefulWidget {
  PersonDao personDao;
  MyHomePage({super.key, required this.title,required this.personDao});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
        Expanded(
          child: StreamBuilder<List<String>>(
            stream:widget.personDao.findAllPersonName(),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return Container();
              final tasks = snapshot.requireData;
              return ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (_, index) {
                     return Text(tasks[index]);
                },
              );
          },
        ),
      ),
    ],
  ),
  floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = Person(19,'Fhranku');
          await widget.personDao.insertPerson(person);
          setState(() {});
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}