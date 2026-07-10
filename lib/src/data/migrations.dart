import 'package:floor/floor.dart';

final migration1To2 = Migration(1, 2, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `Habit` (`name` TEXT NOT NULL, `type` TEXT NOT NULL, `priorityLevel` INTEGER NOT NULL, PRIMARY KEY (`name`))',
  );
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `HabitDate` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `habitName` TEXT NOT NULL, `date` INTEGER NOT NULL)',
  );
});

final migration2To3 = Migration(2, 3, (database) async {
  await database.execute(
    'ALTER TABLE `ActiveUser` ADD COLUMN `imageName` TEXT',
  );
  await database.execute(
    'ALTER TABLE `ActiveUser` ADD COLUMN `points` INTEGER NOT NULL DEFAULT 0',
  );
});

final migration3To4 = Migration(3, 4, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `CompletedDays` (`date` INTEGER NOT NULL, PRIMARY KEY (`date`))',
  );
});

final migration4To5 = Migration(4, 5, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `CompletedHabits` (`habitName` TEXT NOT NULL, `date` INTEGER NOT NULL, PRIMARY KEY (`habitName`, `date`))',
  );
});

final migration5To6 = Migration(5, 6, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `DailyReflections` (`date` INTEGER NOT NULL, `note` TEXT NOT NULL, PRIMARY KEY (`date`))',
  );
});

final migration6To7 = Migration(6, 7, (database) async {
  await database.execute(
    'CREATE TABLE IF NOT EXISTS `PurchasedMarketplaceItem` (`itemId` TEXT NOT NULL, `purchasedAt` INTEGER NOT NULL, PRIMARY KEY (`itemId`))',
  );
});

final migrations = [
  migration1To2,
  migration2To3,
  migration3To4,
  migration4To5,
  migration5To6,
  migration6To7,
];
