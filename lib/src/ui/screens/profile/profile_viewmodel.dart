import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewmodel extends ChangeNotifier {
  ProfileViewmodel(this._activeUserRepository) {
    _load();
  }

  static const _notificationsKey = 'notifications_enabled';

  final ActiveUserRepository _activeUserRepository;
  final ImagePicker _imagePicker = ImagePicker();

  ActiveUser? user;
  bool notificationsEnabled = true;
  bool isLoading = true;

  int get level => ((user?.points ?? 0) ~/ 100) + 1;

  Future<void> _load() async {
    user = await _activeUserRepository.getActiveUser();
    final prefs = await SharedPreferences.getInstance();
    notificationsEnabled = prefs.getBool(_notificationsKey) ?? true;
    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    notificationsEnabled = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_notificationsKey, value);
  }

  Future<void> pickProfilePicture() async {
    final currentUser = user;
    if (currentUser == null) return;

    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;

    final docsDir = await getApplicationDocumentsDirectory();
    final extension = picked.path.split('.').last;
    final savedPath =
        '${docsDir.path}/profile_${currentUser.username}_'
        '${DateTime.now().millisecondsSinceEpoch}.$extension';
    await File(picked.path).copy(savedPath);

    final oldPath = currentUser.imageName;
    if (oldPath != null && oldPath.startsWith('/')) {
      final oldFile = File(oldPath);
      if (await oldFile.exists()) await oldFile.delete();
    }

    final updatedUser = ActiveUser(
      username: currentUser.username,
      email: currentUser.email,
      name: currentUser.name,
      surname: currentUser.surname,
      imageName: savedPath,
      points: currentUser.points,
    );
    await _activeUserRepository.saveActiveUser(updatedUser);
    user = updatedUser;
    notifyListeners();
  }

  Future<void> logout() => _activeUserRepository.clearActiveUser();
}
