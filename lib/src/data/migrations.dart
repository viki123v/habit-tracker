import 'package:floor/floor.dart';

final migration1To2 = Migration(1, 2, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `Habit` (`name` TEXT NOT NULL, `type` TEXT NOT NULL, `priorityLevel` INTEGER NOT NULL, PRIMARY KEY (`name`))',
  );
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `HabitDate` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `habitName` TEXT NOT NULL, `date` INTEGER NOT NULL)',
  );
});

final migrations = [migration1To2];
