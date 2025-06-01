import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin Flutter'),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Plugin Flutter',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 34, 34, 34),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'List of plugins used in this project',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  // const Divider(height: 40, thickness: 1),
                  const SizedBox(height: 10),

                  ExpansionTile(
                    title: const Text('URL Launcher'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Used to open external URLs from within the app. In this project, it allows users to visit the plugin documentation on pub.dev by tapping the link icon.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () => _launchURL('https://pub.dev/packages/url_launcher'),
                        leading: const Icon(Icons.extension, color: Colors.blue),
                        title: const Text('url_launcher: ^6.3.1'),
                        trailing: const Icon(Icons.link, color: Colors.blue),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    title: const Text('Shared Preferences'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Stores user-selected data persistently. In this app, it saves the image path and URL entered by the user, so they are retained even after restarting the app.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () => _launchURL('https://pub.dev/packages/shared_preferences'),
                        leading: const Icon(Icons.extension, color: Colors.blue),
                        title: const Text('shared_preferences: ^2.2.2'),
                        trailing: const Icon(Icons.link, color: Colors.blue),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    title: const Text('Path Provider'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Accesses the device\'s document directory. In this app, it provides a valid file path to save a copy of the image picked by the user.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () => _launchURL('https://pub.dev/packages/path_provider'),
                        leading: const Icon(Icons.extension, color: Colors.blue),
                        title: const Text('path_provider: ^2.1.2'),
                        trailing: const Icon(Icons.link, color: Colors.blue),
                      ),
                    ],
                  ),

                  ExpansionTile(
                    title: const Text('Image Picker'),
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Enables users to select an image from the gallery or capture one using the camera. This image is then saved locally and referenced in the app.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      ListTile(
                        onTap: () => _launchURL('https://pub.dev/packages/image_picker'),
                        leading: const Icon(Icons.extension, color: Colors.blue),
                        title: const Text('image_picker: ^1.1.2'),
                        trailing: const Icon(Icons.link, color: Colors.blue),
                      ),
                    ],
                  ),


                  const SizedBox(height: 30),
                  const Center(
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: Text('Developed by'),
                      subtitle: Text('FADHILAH HAMID'),
                    ),
                  ),
                  const SizedBox(height: 30),

                  InkWell(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Opening example ...')),
                      );
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.of(context).pushNamed('/example');
                      });
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF0055FF), Color(0xFF07C9FF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(Icons.remove_red_eye, color: Colors.white),
                          SizedBox(width: 10),
                          Text(
                            'See Example',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
