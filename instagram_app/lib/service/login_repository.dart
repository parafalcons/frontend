// Repository Class
import 'dart:convert';

import '../app/config.dart';
import '../models/reel_content_model.dart';
import '../models/user.dart';
import '../utils/session_manager.dart';
import 'api_service.dart';
import 'package:http/http.dart' as http;


class AuthRepository {
  Future<bool?> checkUserExists(String userName) async {
    Uri url = Uri.parse('${Config.domainUrl}${Config.userExistsEndpoint}?userName=$userName');
    print("UserName : $userName");
    print(url);
    final respBody = await ApiService().get(url);
    print(respBody);
    return respBody == true;
  }

  Future<User?> login(String userName, String password) async {
    final data = await loginApi(userName, password);
    if (data != null && data['token'] != null) {
      await SessionManager.saveSession(data['token'], userName); // Save token & username
      return User.fromJson(data);
    }
    return null;
  }

  Future<dynamic> loginApi(String userName, String password) async {
    Uri url = Uri.parse('${Config.domainUrl}${Config.loginEndpoint}');
    var bodyObj = {
      'usernameOrEmail': userName,
      'password': password,
    };
    print(bodyObj);
    print(url);

    final body = jsonEncode(bodyObj);
    final respBody = await ApiService().post(url, body: body);
    print(respBody);

    return respBody;
  }

  Future<bool> signUp(User user, String password) async {
    Uri url = Uri.parse('${Config.domainUrl}${Config.signUpEndpoint}');
    var bodyObj = {
      'fullName': user.fullName,
      'username': user.userName,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'password': password,
    };
    print(bodyObj);
    print(url);

    final body = jsonEncode(bodyObj);
    final respBody = await ApiService().post(url, body: body);
    print(respBody);

    if (respBody == "User already exists") {
      print("User already exists. Please try logging in.");
      return false;
    } else if (respBody == "User registered successfully") {
      print("User registered successfully.");
      return true;
    }

    print("Unexpected response: $respBody");
    return false;
  }


  Future<bool> uploadVideo(String filePath, String userId, String title, String description) async {
    Uri url = Uri.parse(Config.videosUploadEndpoint);
    var request = http.MultipartRequest('POST', url);
    var id = await SessionManager.getUserName();
    print(id);
    request.files.add(await http.MultipartFile.fromPath('file', filePath));
    request.fields['userId'] = id ?? "";
    request.fields['title'] = title;
    request.fields['description'] = description;
    print(request);
    var response = await request.send();
    print(response.statusCode);

    return response.statusCode == 200;
  }

  Future<List<Video>> getVideos() async {
    Uri url = Uri.parse(Config.videosEndpoint);
    final response = await ApiService().get(url);

    if (response != null) {
      try {
        // If response is already a List, return it directly
        if (response is List) {
          print("Response is already a List<dynamic>, mapping to Video objects...");
          return response.map((json) => Video.fromJson(json)).toList();
        }

        // If response is a String, decode it
        if (response is String) {
          print("Response is a String, decoding JSON...");
          List<dynamic> jsonData = jsonDecode(response);

          if (jsonData is List) {
            print("Parsed video data: $jsonData");
            return jsonData.map((json) => Video.fromJson(json)).toList();
          } else {
            throw Exception("Unexpected API response format");
          }
        }

        throw Exception("Unexpected response type: ${response.runtimeType}");

      } catch (e) {
        print("Error parsing videos: $e");
        throw Exception("Failed to parse videos");
      }
    }

    return [];
  }


}
