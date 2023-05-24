import 'package:floor/floor.dart';
import 'package:pollutrack/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class ExposuresDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Exposure table of a certain date
  @Query(
      'SELECT * FROM Exposure WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Exposure>> findExposuresbyDate(
      DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Exposure table
  @Query('SELECT * FROM Exposure')
  Future<List<Exposure>> findAllExposures();

  //Query #2: INSERT -> this allows to add a Exposure in the table
  @insert
  Future<void> insertExposure(Exposure exposures);

  //Query #3: DELETE -> this allows to delete a Exposure from the table
  @delete
  Future<void> deleteExposure(Exposure exposures);

  //Query #4: UPDATE -> this allows to update a Exposure entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateExposure(Exposure exposures);

  @Query('SELECT * FROM Exposure ORDER BY dateTime ASC LIMIT 1')
  Future<Exposure?> findFirstDayInDb();

  @Query('SELECT * FROM Exposure ORDER BY dateTime DESC LIMIT 1')
  Future<Exposure?> findLastDayInDb();
}//ExposuresDao