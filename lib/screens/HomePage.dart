import 'package:floor_database/floor/dao/PersonDao.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../floor/entity/Person.dart';


class HomePage extends StatefulWidget {
  PersonDao personDao;
  HomePage({super.key,required this.personDao});
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Floor'),
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
                     return Obx(() =>  Text(tasks[index]));
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
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}