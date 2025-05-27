import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'song_list.dart';
import 'user_profile.dart';
import 'favorite_page.dart';
import 'settings_page.dart';
import 'song_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FBOX 🎧',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: const Color.fromARGB(255, 5, 13, 67),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 5, 13, 67),
          titleTextStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      home: const HomePage(),
      routes: {'/settings': (context) => const SettingsPage()},
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredSongs = [];

  int _selectedIndex = 0;

  final List<Map<String, String>> songs = const [
    {
      "title": "/ forever more /",
      "artist": "Gamaliel",
      "genre": "Pop",
      "image": "assets/q1.png",
      "year": "2021",
      "songwriter": "Gamaliel Tapiheru",
      "composer": "Gamaliel Tapiheru",
      "album": "Q1",
    },
    {
      "title": "Always",
      "artist": "Daniel Caesar",
      "genre": "Pop",
      "image": "assets/always.png",
      "year": "2023",
      "songwriter": "Daniel Caesar",
      "composer": "Daniel Caesar",
      "album": "NEVER ENOUGH",
    },
    {
      "title": "Blue",
      "artist": "Jackson Wang",
      "genre": "Pop",
      "image": "assets/blue.jpeg",
      "year": "2022",
      "songwriter": "Jackson Wang",
      "composer": "Jackson Wang, Mirror Music",
      "album": "MAGIC MAN",
    },
    {
      "title": "Ditto",
      "artist": "NewJeans",
      "genre": "K-Pop",
      "image": "assets/ditto.jpg",
      "year": "2022",
      "songwriter": "250, Ylva Dimberg",
      "composer": "250",
      "album": "OMG (Single Album)",
    },
    {
      "title": "ETA",
      "artist": "NewJeans",
      "genre": "K-Pop",
      "image": "assets/eta.jpg",
      "year": "2023",
      "songwriter": "Beenzino, Ylva Dimberg",
      "composer": "250",
      "album": "Get Up",
    },
    {
      "title": "Fine Line",
      "artist": "Harry Styles",
      "genre": "Pop",
      "image": "assets/fineline.jpeg",
      "year": "2019",
      "songwriter": "Harry Styles, Thomas Hull, Tyler Johnson",
      "composer": "Harry Styles, Thomas Hull, Tyler Johnson",
      "album": "Fine Line",
    },
    {
      "title": "If I Got You",
      "artist": "ZAYN",
      "genre": "Pop",
      "image": "assets/ifgot.jpeg",
      "year": "2023",
      "songwriter": "ZAYN",
      "composer": "ZAYN",
      "album": "Room Under the Stairs",
    },
    {
      "title": "her",
      "artist": "GOT7",
      "genre": "K-Pop",
      "image": "assets/got7.jpeg",
      "year": "2018",
      "songwriter": "JB (Defsoul), MirrorBOY, Munhan Mirror",
      "composer": "Defsoul, Munhan Mirror, MirrorBOY",
      "album": "Present: YOU",
    },
    {
      "title": "Lied To",
      "artist": "ZAYN",
      "genre": "Pop",
      "image": "assets/liedto.jpeg",
      "year": "2023",
      "songwriter": "ZAYN",
      "composer": "ZAYN",
      "album": "Room Under the Stairs",
    },
    {
      "title": "Little Window",
      "artist": "FINNEAS",
      "genre": "Pop",
      "image": "assets/window.png",
      "year": "2023",
      "songwriter": "Finneas O'Connell",
      "composer": "Finneas O'Connell",
      "album": "For Cryin' Out Loud!",
    },
    {
      "title": "Love Wins All",
      "artist": "IU",
      "genre": "K-Pop",
      "image": "assets/iu.png",
      "year": "2024",
      "songwriter": "IU",
      "composer": "IU, Seo Dong-hwan",
      "album": "The Winning",
    },
    {
      "title": "Monster in Me",
      "artist": "Little Mix",
      "genre": "Pop",
      "image": "assets/lm5.jpeg",
      "year": "2018",
      "songwriter":
          "Jess Glynne, Edvard Forre Erfjord, Henrik Barman Michelsen",
      "composer": "Jess Glynne, Electric",
      "album": "LM5",
    },
    {
      "title": "Oceans & Engines",
      "artist": "NIKI",
      "genre": "Pop",
      "image": "assets/oceans.jpg",
      "year": "2022",
      "songwriter": "NIKI",
      "composer": "NIKI",
      "album": "Nicole",
    },
    {
      "title": "Shape of You",
      "artist": "Ed Sheeran",
      "genre": "Pop",
      "image": "assets/ed.png",
      "year": "2017",
      "songwriter": "Ed Sheeran, Steve Mac, Johnny McDaid",
      "composer": "Ed Sheeran, Steve Mac",
      "album": "÷ (Divide)",
    },
    {
      "title": "So Long, London",
      "artist": "Taylor Swift",
      "genre": "Pop",
      "image": "assets/london.png",
      "year": "2024",
      "songwriter": "Taylor Swift",
      "composer": "Taylor Swift, Aaron Dessner",
      "album": "The Tortured Poets Department",
    },
    {
      "title": "Star",
      "artist": "Colde",
      "genre": "K-Pop",
      "image": "assets/star.jpg",
      "year": "2020",
      "songwriter": "Colde",
      "composer": "Colde",
      "album": "Idealism",
    },
    {
      "title": "Someday It's Time to Shine",
      "artist": "Mido and Falasol",
      "genre": "K-Pop",
      "image": "assets/toshine.png",
      "year": "2025",
      "songwriter": "Lee Jun Hyung, MAO",
      "composer": "Lee Jun Hyung",
      "album": "Resident Playbook OST",
    },
    {
      "title": "stay a little longer",
      "artist": "ROSÉ",
      "genre": "K-Pop",
      "image": "assets/staylonger.jpeg",
      "year": "2021",
      "songwriter": "ROSÉ",
      "composer": "ROSÉ",
      "album": "R (Project Film)",
    },
    {
      "title": "Thank You",
      "artist": "GOT7",
      "genre": "K-Pop",
      "image": "assets/thankyou.jpg",
      "year": "2018",
      "songwriter": "Jinyoung, Mirror BOY",
      "composer": "Mirror BOY, D.ham, Munhan Mirror",
      "album": "Eyes On You",
    },
    {
      "title": "TOXIC",
      "artist": "MEOVV",
      "genre": "K-Pop",
      "image": "assets/toxic.jpg",
      "year": "2023",
      "songwriter": "MEOVV",
      "composer": "MEOVV",
      "album": "MY EYES OPEN VVIDE",
    },
    {
      "title": "WILDFLOWER",
      "artist": "Billie Eilish",
      "genre": "Pop",
      "image": "assets/wild.png",
      "year": "2024",
      "songwriter": "Billie Eilish",
      "composer": "Finneas O'Connell",
      "album": "Hit Me Hard and Soft",
    },
    {
      "title": "Woojooin",
      "artist": "Soe Young Joo (OST Melo Movie)",
      "genre": "K-Pop",
      "image": "assets/woojooin.png",
      "year": "2024",
      "songwriter": "Unknown",
      "composer": "Unknown",
      "album": "Melo Movie OST",
    },
  ];

  void _filterSongs(String query) {
    setState(() {
      filteredSongs =
          songs
              .where(
                (song) =>
                    song['title']!.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    song['artist']!.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
    });
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const FavoritePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const UserProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 5, 13, 67),
              Color.fromARGB(255, 7, 18, 90),
              Color.fromARGB(255, 80, 123, 243),
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 180,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/banner.jpg', fit: BoxFit.cover),

                  // Overlay hitam semi-transparan seluruh banner
                  Container(color: Colors.black.withOpacity(0.5)),

                  // Efek gradasi pudar di bawah banner
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 50,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(34, 6, 15, 75),
                            Color.fromARGB(255, 5, 13, 67),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Tombol settings
                  Positioned(
                    top: 5,
                    right: 5,
                    child: IconButton(
                      icon: const Icon(
                        Icons.settings,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SettingsPage(),
                          ),
                        );
                      },
                    ),
                  ),

                  // Teks di tengah banner
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'FBOX',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                color: Color.fromARGB(216, 255, 255, 255),
                                offset: Offset(2, 3),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Music Platform',
                          style: TextStyle(
                            fontFamily: 'Orbitron',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),
            const Text(
              'From chill to thrill—play what you feel',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),

            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70),
              child: TextField(
                controller: _searchController,
                onChanged: _filterSongs,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search for a song or artist...',
                  hintStyle: const TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 25),
            const Text(
              'Genre Populer:',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 15),
            if (_searchController.text.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: filteredSongs.length,
                  itemBuilder: (context, index) {
                    final song = filteredSongs[index];
                    return ListTile(
                      leading: Image.asset(
                        song['image']!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        song['title']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        song['artist']!,
                        style: const TextStyle(color: Colors.white70),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => SongDetailPage(
                                  songs: filteredSongs,
                                  currentIndex: index,
                                ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            else
              const Expanded(child: _GenreGrid()),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 4, 11, 56),
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(171, 255, 255, 255),
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
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

class _GenreGrid extends StatefulWidget {
  const _GenreGrid();

  @override
  State<_GenreGrid> createState() => _GenreGridState();
}

class _GenreGridState extends State<_GenreGrid> {
  static const List<String> genres = [
    'Pop',
    'Rock',
    'Hip-Hop',
    'K-Pop',
    'Jazz',
  ];

  static const Map<String, Map<String, dynamic>> genreStyles = {
    'Pop': {
      'icon': Icons.music_note,
      'textColor': Color(0xFF062F75),
      'iconColor': Color(0xFF062F75),
    },
    'Rock': {
      'icon': Icons.surround_sound,
      'textColor': Color(0xFF89100E),
      'iconColor': Color(0xFF89100E),
    },
    'Hip-Hop': {
      'icon': Icons.headset_mic,
      'textColor': Color(0xFFA2870D),
      'iconColor': Color(0xFFA2870D),
    },
    'K-Pop': {
      'icon': Icons.favorite,
      'textColor': Color(0xFF550863),
      'iconColor': Color(0xFF550863),
    },
    'Jazz': {
      'icon': Icons.audiotrack,
      'textColor': Color(0xFF08660D),
      'iconColor': Color(0xFF08660D),
    },
  };

  final Map<String, bool> _isHovered = {};

  Widget _buildGenreBox(BuildContext context, String genre) {
    final style = genreStyles[genre]!;

    _isHovered.putIfAbsent(genre, () => false);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered[genre] = true),
      onExit: (_) => setState(() => _isHovered[genre] = false),
      child: AnimatedScale(
        scale: _isHovered[genre]! ? 0.95 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.all(10),
          width: 165,
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.85),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 6,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SongListPage(genre: genre)),
              );
            },
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(style['icon'], size: 30, color: style['iconColor']),
                  const SizedBox(height: 6),
                  Text(
                    genre,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: style['textColor'],
                      shadows: const [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenreBox(context, genres[0]),
                _buildGenreBox(context, genres[1]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildGenreBox(context, genres[2]),
                _buildGenreBox(context, genres[3]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_buildGenreBox(context, genres[4])],
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
