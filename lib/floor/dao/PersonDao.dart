import 'package:floor/floor.dart';
import '../entity/Person.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM Person')
  Future<List<Person>> findAllPerson();

  @Query('SELECT name FROM Person')
  Stream<List<String>> findAllPersonName();

  @Query('SELECT * FROM Person WHERE id = :id')
  Stream<Person?> findPersonById(int id);

  @Query('UPDATE Person SET name=:name  WHERE id = :id')
  Stream<Person?> updatePersonById(String name,int id);

  @insert
  Future<void> insertPerson(Person person);

  @delete
  Future<void> deletePerson(Person id);


}