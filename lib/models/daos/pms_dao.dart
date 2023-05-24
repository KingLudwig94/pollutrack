import 'package:floor/floor.dart';
import 'package:pollutrack/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class PmsDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the PM25 table of a certain date
  @Query('SELECT * FROM PM25 WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<PM25>> findPmsbyDate(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the PM table
  @Query('SELECT * FROM PM25')
  Future<List<PM25>> findAllPms();

  //Query #2: INSERT -> this allows to add a PM in the table
  @insert
  Future<void> insertPm(PM25 pms);

  //Query #3: DELETE -> this allows to delete a PM from the table
  @delete
  Future<void> deletePm(PM25 pms);

  //Query #4: UPDATE -> this allows to update a PM entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePm(PM25 pms);
}//PmsDao