import 'package:flutter/material.dart';
import '../models/reel_content_model.dart';
import '../models/user.dart';
import '../service/login_repository.dart';
import '../utils/session_manager.dart';


// ViewModel Class
// ViewModel Class
class AuthViewModel extends ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  User? get user => _user;
  List<Video> _videos = [];
  String? _error;

  List<Video> get videos => _videos;
  String? get error => _error;

  Future<void> login(String userName, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      _user = await AuthRepository().login(userName, password);
      if (_user == null) {
        throw Exception('Invalid username or password');
      }
    } catch (e) {
      return ;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signUp(User user, String password) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await AuthRepository().signUp(user, password);
      return success;
    } catch (e) {
      notifyErrorToListeners(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool?> checkUserExists(String userName) async {
    return await AuthRepository().checkUserExists(userName);
  }

  Future<bool> uploadVideo(String filePath, String userId, String title, String description) async {
    _isLoading = true;
    notifyListeners();
    try {
      bool success = await AuthRepository().uploadVideo(filePath, userId, title, description);
      return success;
    } catch (e) {
      notifyErrorToListeners(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getVideos() async {
    _isLoading = true;
    notifyListeners();

    try {
      print("Fetching videos from API...");
      _videos = await AuthRepository().getVideos();
      print("Videos fetched: ${_videos.length}");
      for (var video in _videos) {
        print("Video URL: ${video.s3Url}");
      }
    } catch (e) {
      _error = e.toString();
      print("Error fetching videos: $_error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _user = null;
    await SessionManager.logout();
    notifyListeners();
  }

  void notifyErrorToListeners(dynamic error) {
    debugPrint('Error: $error');
  }
}
