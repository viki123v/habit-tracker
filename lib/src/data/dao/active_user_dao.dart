import 'package:floor/floor.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';

@dao
abstract class ActiveUserDao {
  @Query("SELECT * FROM ActiveUser LIMIT 1")
  Future<ActiveUser?> getActiveUser();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveActiveUser(ActiveUser user);

  @Query("UPDATE ActiveUser SET points = points + :points")
  Future<void> addPoints(int points);

  @Query("DELETE FROM ActiveUser")
  Future<void> clearActiveUser();
}
