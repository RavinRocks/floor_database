import 'package:floor/floor.dart';

@entity
class Person{
  @PrimaryKey(autoGenerate: true)
  int? id;
  String name;
  Person(this.id, this.name);
}