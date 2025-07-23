import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class MomentsPage extends StatefulWidget {
  const MomentsPage({super.key});

  @override
  _MomentsPageState createState() => _MomentsPageState();
}

class _MomentsPageState extends State<MomentsPage> {
  final List<Map<String, dynamic>> _moments = [];
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  void _postMoment() {
    if (_selectedImage != null || _captionController.text.trim().isNotEmpty) {
      setState(() {
        _moments.insert(0, {
          'image': _selectedImage,
          'caption': _captionController.text.trim(),
        });
        _captionController.clear();
        _selectedImage = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Share Your Moments'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    decoration: const InputDecoration(
                      hintText: 'Write a caption...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.image, color: Colors.black),
                  onPressed: _pickImage,
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.green),
                  onPressed: _postMoment,
                ),
              ],
            ),
          ),
          Expanded(
            child: _moments.isEmpty
                ? const Center(child: Text("No moments shared yet."))
                : ListView.builder(
                    itemCount: _moments.length,
                    itemBuilder: (context, index) {
                      final moment = _moments[index];
                      return Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (moment['image'] != null && moment['image'] is File)
                              Image.file(moment['image'], fit: BoxFit.cover, width: double.infinity, height: 200),
                            if (moment['caption'].isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(moment['caption'], style: const TextStyle(fontSize: 16)),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}












