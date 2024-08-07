import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class PalettePage extends StatefulWidget {
  const PalettePage({super.key});

  @override
  _PalettePageState createState() => _PalettePageState();
}

class _PalettePageState extends State<PalettePage> {
  List<dynamic> _palettes = [];

  @override
  void initState() {
    super.initState();
    _fetchPalettes();
  }

  Future<void> _fetchPalettes() async {
    try {
      final response = await http.get(
        Uri.parse('https://color.tricks.se/app/get_palettes_api.php'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );

      print(response.body); // Debugging line to check response

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (responseData['status'] == 'success') {
        setState(() {
          _palettes = responseData['data'];
        });
      } else {
        if (responseData['message'] == 'User not logged in.') {
          // If user is not logged in, log out and navigate to login page
          _logout(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData['message'])),
          );
        }
      }
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load palettes. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Palettes'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: _palettes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _palettes.length,
        itemBuilder: (context, index) {
          final palette = _palettes[index];
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    palette['pack_name'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Wrap(
                    children: List.generate(10, (colorIndex) {
                      final colorKey = 'color${colorIndex + 1}';
                      final colorValue = palette[colorKey];
                      if (colorValue != null && colorValue.isNotEmpty) {
                        return GestureDetector(
                          onTap: () => _copyToClipboard(context, colorValue),
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Color(int.parse(
                                '0xff${colorValue.substring(1)}')),
                            margin: EdgeInsets.only(right: 4, bottom: 4),
                          ),
                        );
                      }
                      return SizedBox.shrink();
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => _editColorPack(palette['id']),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _confirmDelete(palette['id']),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied: $text')),
    );
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('username'); // Remove the stored username
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _confirmDelete(int paletteId) {
    // Add your delete logic here
  }

  void _editColorPack(int paletteId) {
    // Add your edit logic here
  }
}
