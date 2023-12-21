import 'package:floor/floor.dart';

@entity
class Person{
  @primaryKey
  final int id;
  String name;
  Person(this.id, this.name);
}