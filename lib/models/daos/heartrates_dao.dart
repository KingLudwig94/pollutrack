import 'package:floor/floor.dart';
import 'package:pollutrack/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class HeartRatesDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the HR table of a certain date
  @Query('SELECT * FROM HR WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<HR>> findHeartRatesbyDate(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the HR table
  @Query('SELECT * FROM HR')
  Future<List<HR>> findAllHeartRates();

  //Query #2: INSERT -> this allows to add a HR in the table
  @insert
  Future<void> insertHeartRate(HR heartRates);

  //Query #3: DELETE -> this allows to delete a HR from the table
  @delete
  Future<void> deleteHeartRate(HR heartRates);

  //Query #4: UPDATE -> this allows to update a HR entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateHeartRate(HR heartRates);
}//HeartRatesDao