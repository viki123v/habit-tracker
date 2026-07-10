import 'package:flutter/foundation.dart';
import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';

class ActiveUserRepository extends ChangeNotifier {
  final ActiveUserDao _activeUserDao;

  ActiveUserRepository(this._activeUserDao);

  Future<ActiveUser?> getActiveUser() => _activeUserDao.getActiveUser();

  Future<void> saveActiveUser(ActiveUser user) async {
    await _activeUserDao.clearActiveUser();
    await _activeUserDao.saveActiveUser(user);
    notifyListeners();
  }

  Future<void> addPoints(int points) async {
    await _activeUserDao.addPoints(points);
    notifyListeners();
  }

  Future<void> clearActiveUser() async {
    await _activeUserDao.clearActiveUser();
    notifyListeners();
  }
}
