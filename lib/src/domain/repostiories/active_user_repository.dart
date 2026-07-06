import 'package:habit_tracker/src/data/dao/active_user_dao.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';

class ActiveUserRepository {
  final ActiveUserDao _activeUserDao;

  ActiveUserRepository(this._activeUserDao);

  Future<ActiveUser?> getActiveUser() => _activeUserDao.getActiveUser();

  Future<void> saveActiveUser(ActiveUser user) async {
    await _activeUserDao.clearActiveUser();
    await _activeUserDao.saveActiveUser(user);
  }

  Future<void> clearActiveUser() => _activeUserDao.clearActiveUser();
}
