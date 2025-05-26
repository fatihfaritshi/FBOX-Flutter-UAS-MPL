import 'package:flutter/material.dart';
import 'song_detail.dart';
import 'user_profile.dart';

class SongListPage extends StatefulWidget {
  final String genre;

  const SongListPage({super.key, required this.genre});

  @override
  State<SongListPage> createState() => _SongListPageState();
}

class _SongListPageState extends State<SongListPage>
    with SingleTickerProviderStateMixin {
  // Example song list (you can replace this with your actual data)
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
  ];

  late List<bool> isFavoriteList;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    isFavoriteList = List<bool>.filled(songs.length, false);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
      lowerBound: 0.7,
      upperBound: 1.0,
    );

    _scaleAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void toggleFavorite(int index) async {
    await _animationController.forward();
    await _animationController.reverse();

    setState(() {
      isFavoriteList[index] = !isFavoriteList[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredSongs =
        songs.where((song) => song['genre'] == widget.genre).toList();

    // Ensure isFavoriteList matches filteredSongs length (in case of filtering)
    if (isFavoriteList.length != filteredSongs.length) {
      isFavoriteList = List<bool>.filled(filteredSongs.length, false);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Genre: ${widget.genre}',
          style: const TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const UserProfilePage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: filteredSongs.length,
        itemBuilder: (context, index) {
          final song = filteredSongs[index];
          final isFavorite = isFavoriteList[index];

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
              ),
            ),
            subtitle: Text(
              '${song['artist']} • ${song['album']} • ${song['year']}',
              style: const TextStyle(fontFamily: 'Montserrat', fontSize: 13),
            ),
            trailing: ScaleTransition(
              scale: _scaleAnimation,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? const Color.fromARGB(255, 41, 50, 139) : Colors.grey,
                ),
                onPressed: () {
                  toggleFavorite(index);
                },
                tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongDetailPage(
                    songs: filteredSongs,
                    currentIndex: index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}