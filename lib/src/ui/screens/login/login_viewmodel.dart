import 'package:flutter/foundation.dart';
import 'package:habit_tracker/src/data/models/active_user.dart';
import 'package:habit_tracker/src/domain/repostiories/active_user_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final ActiveUserRepository _activeUserRepository;

  LoginViewModel(this._activeUserRepository);

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login({required String email, required String password}) async {
    if (_isLoading) return false;

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail.isEmpty || password.length < 6) {
      _errorMessage = 'Enter a valid email and password.';
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final username = normalizedEmail.split('@').first;

      await _activeUserRepository.saveActiveUser(
        ActiveUser(
          username: username,
          email: normalizedEmail,
          name: username,
          surname: '',
        ),
      );
      return true;
    } catch (_) {
      _errorMessage = 'Could not log in. Please try again.';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> isLoggedIn() async =>  await _activeUserRepository.getActiveUser().then((activeUser) => activeUser != null);
}
