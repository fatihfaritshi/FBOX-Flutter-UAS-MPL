import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_profile.dart';
import 'main.dart';
import 'song_detail.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<String> folderList = [];
  List<Map<String, dynamic>> favoriteSongs = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
    _loadFolders();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favData = prefs.getStringList('favoriteSongs') ?? [];
    setState(() {
      favoriteSongs =
          favData.map((s) => jsonDecode(s) as Map<String, dynamic>).toList();
    });
  }

  Future<void> _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFolders = prefs.getStringList('folders') ?? [];
    setState(() {
      folderList = savedFolders;
    });
  }

  Future<void> _saveFolders() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('folders', folderList);
  }

  void _showCreateFolderDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Create New Folder'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Folder Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  String folderName = controller.text.trim();
                  if (folderName.isNotEmpty) {
                    setState(() {
                      folderList.add(folderName);
                    });
                    _saveFolders();
                  }
                  Navigator.pop(context);
                },
                child: const Text('Create'),
              ),
            ],
          ),
    );
  }

  void _showEditFolderDialog(int index) {
    final TextEditingController controller = TextEditingController(
      text: folderList[index],
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Folder Name'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'New Folder Name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  String newName = controller.text.trim();
                  if (newName.isNotEmpty) {
                    setState(() {
                      folderList[index] = newName;
                    });
                    _saveFolders();
                  }
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  void _deleteFolder(int index) {
    setState(() {
      folderList.removeAt(index);
    });
    _saveFolders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorite'),
        backgroundColor: const Color.fromARGB(255, 5, 13, 67),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 5, 13, 67),
              Color.fromARGB(255, 41, 50, 139),
              Color.fromARGB(255, 80, 123, 243),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child:
                  favoriteSongs.isEmpty
                      ? const Center(
                        child: Text(
                          'No favorite songs added yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: favoriteSongs.length,
                        itemBuilder: (context, index) {
                          final song = favoriteSongs[index];
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                song['image'] ?? '',
                                width: 50,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              song['title'] ?? '',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              '${song['artist']} • ${song['album']} • ${song['year']}',
                              style: const TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                color: Colors.white70,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                setState(() {
                                  favoriteSongs.removeAt(index);
                                  prefs.setStringList(
                                    'favoriteSongs',
                                    favoriteSongs
                                        .map((e) => jsonEncode(e))
                                        .toList(),
                                  );
                                });
                              },
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => SongDetailPage(
                                        songs:
                                            favoriteSongs
                                                .map(
                                                  (e) => e.map(
                                                    (key, value) => MapEntry(
                                                      key,
                                                      value.toString(),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                        currentIndex: index,
                                      ),
                                ),
                              );
                            },
                          );
                        },
                      ),
            ),
            const Divider(color: Colors.white),
            Expanded(
              flex: 1,
              child:
                  folderList.isEmpty
                      ? const Center(
                        child: Text(
                          'No folders created yet',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      )
                      : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: folderList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 236, 236, 236),
                                  Color.fromARGB(255, 198, 200, 201),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(2, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.folder,
                                  size: 48,
                                  color: Color.fromARGB(255, 5, 13, 67),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    folderList[index],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 5, 13, 67),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 24,
                                    color: Color.fromARGB(255, 5, 13, 67),
                                  ),
                                  onPressed: () => _showEditFolderDialog(index),
                                  tooltip: 'Edit',
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 24,
                                    color: Color.fromARGB(255, 5, 13, 67),
                                  ),
                                  onPressed: () => _deleteFolder(index),
                                  tooltip: 'Delete',
                                ),
                              ],
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateFolderDialog,
        backgroundColor: const Color.fromARGB(255, 5, 13, 67),
        child: const Icon(Icons.create_new_folder, color: Colors.white),
        tooltip: 'Create New Folder',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 5, 13, 67),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(171, 255, 255, 255),
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const UserProfilePage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
