import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../app/config.dart';
import '../utils/session_manager.dart';

class UploadTab extends StatefulWidget {
  @override
  _UploadTabState createState() => _UploadTabState();
}

class _UploadTabState extends State<UploadTab> {
  File? _videoFile;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickVideo() async {
    try {
      final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _videoFile = File(pickedFile.path);
        });
        print("Selected video path: ${pickedFile.path}");
      } else {
        print("No video selected");
      }
    } catch (e) {
      print("Error picking video: $e");
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null || _titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select a video and fill in all fields.")));
      return;
    }

    setState(() {
      _isUploading = true;
    });


    bool success = await uploadVideo(
      _videoFile!.path,
      "userId123", // Replace with actual user ID
      _titleController.text,
      _descriptionController.text,
    );

    setState(() {
      _isUploading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Video uploaded successfully!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Video upload failed.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _videoFile == null
              ? Text("No video selected", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
              : Column(
            children: [
              Icon(Icons.video_file, size: 100, color: Colors.blue),
              SizedBox(height: 10),
              Text(
                'Selected Video: ${_videoFile!.path.split('/').last}',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 20),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: "Title"),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: "Description"),
          ),
          SizedBox(height: 20),
          _isUploading
              ? CircularProgressIndicator()
              : Column(
            children: [
              ElevatedButton(
                onPressed: _pickVideo,
                child: Text("Pick Video"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadVideo,
                child: Text("Upload Video"),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
  print(request.fields);
  var response = await request.send();
  print(response.statusCode);

  return response.statusCode == 200;
}
