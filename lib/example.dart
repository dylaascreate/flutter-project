import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _urlController = TextEditingController();
  String? _savedUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  Future<void> _pickImage(ImageSource source) async {
  final pickedFile = await _picker.pickImage(source: source);
  if (pickedFile != null) {
    setState(() => _isLoading = true);
    try {
      final tempFile = File(pickedFile.path);

      // Use path_provider to get app's document directory
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = pickedFile.name;
      final savedImage = await tempFile.copy('${appDir.path}/$fileName');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('imagePath', savedImage.path); // Save new path

      setState(() {
        _imageFile = savedImage;
      });
    } catch (e) {
      debugPrint('Image pick error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load image')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
}


  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    if (_imageFile != null) {
      await prefs.setString('imagePath', _imageFile!.path);
    }
    await prefs.setString('url', _urlController.text);
    setState(() {
      _savedUrl = _urlController.text;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data saved')),
    );
  }

 Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('imagePath');
    final savedUrl = prefs.getString('url');

    debugPrint('Loaded imagePath: $imagePath');

    if (imagePath != null) {
      final file = File(imagePath);
      final exists = file.existsSync();
      debugPrint('Image file exists: $exists');
      if (exists) {
        setState(() {
          _imageFile = file;
        });
      }
    }

    if (savedUrl != null) {
      setState(() {
        _savedUrl = savedUrl;
        _urlController.text = savedUrl;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Example Page'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _isLoading
                ? const CircularProgressIndicator()
                : _imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(
                          _imageFile!,
                          width: 200,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Text('No image selected.', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shadowColor: Colors.blue,
                elevation: 6,
              ),
              onPressed: _isLoading ? null : () => _pickImage(ImageSource.gallery),
              icon: const Icon(Icons.photo),
              label: const Text('Pick from Gallery'),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shadowColor: Colors.blue,
                elevation: 6,
              ),
              onPressed: _isLoading ? null : () => _pickImage(ImageSource.camera),
              icon: const Icon(Icons.camera),
              label: const Text('Take a Photo'),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Enter a URL',
                labelStyle: const TextStyle(color: Colors.blue),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.url,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 10),

            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                shadowColor: Colors.blue.withOpacity(0.4),
                elevation: 6,
              ),
              onPressed: _isLoading ? null : _saveData,
              icon: const Icon(Icons.save),
              label: const Text('Save Data'),
            ),
            const Divider(height: 40, thickness: 1),

            Text('Saved Data:', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_imageFile!, width: 100, height: 100, fit: BoxFit.cover),
                  )
                : Text('No saved image', style: theme.textTheme.bodyMedium),
            const SizedBox(height: 10),
            _savedUrl != null
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.link, color: Colors.blue),
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () => _launchURL(_savedUrl!),
                        child: Text(
                          _savedUrl!,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  )
                : Text('No saved URL', style: theme.textTheme.bodyMedium),
            // Add the Clear Data button as a separate child in the Column
            IconButton(
              onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.remove('imagePath');
              await prefs.remove('url');
              setState(() {
                _imageFile = null;
                _savedUrl = null;
                _urlController.clear();
              });
                  },
                  icon: const Icon(Icons.repeat),
                  tooltip: 'Refresh',
                  color: Colors.red,
                  iconSize: 32,
                ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $urlString')),
      );
    }
  }
}
