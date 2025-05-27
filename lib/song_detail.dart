import 'package:flutter/material.dart';

class SongDetailPage extends StatefulWidget {
  final List<Map<String, String>> songs;
  final int currentIndex;

  const SongDetailPage({
    required this.songs,
    required this.currentIndex,
    super.key,
  });

  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage>
    with TickerProviderStateMixin {
  bool isPlaying = false;
  bool showInfo = false;

  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  late int currentIndex;

  @override
  void initState() {
    super.initState();

    currentIndex = widget.currentIndex;

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  void togglePlay() {
    if (isPlaying) {
      _scaleController.stop();
      _rotationController.stop();
      _scaleController.reset();
      _rotationController.reset();
    } else {
      _scaleController.repeat(reverse: true);
      _rotationController.repeat();
    }

    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void previousSong() {
    setState(() {
      currentIndex =
          (currentIndex - 1 + widget.songs.length) % widget.songs.length;
      isPlaying = false;
      _scaleController.reset();
      _rotationController.reset();
    });
  }

  void nextSong() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.songs.length;
      isPlaying = false;
      _scaleController.reset();
      _rotationController.reset();
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final song = widget.songs[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(song['title'] ?? ''),
        backgroundColor: const Color.fromARGB(255, 5, 13, 67),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: 'Show song info',
            onPressed: () {
              setState(() {
                showInfo = !showInfo;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 5, 13, 67),
                  Color.fromARGB(255, 41, 50, 139),
                  Color.fromARGB(255, 80, 123, 243),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RotationTransition(
                    turns: _rotationAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: CircleAvatar(
                        radius: 90,
                        backgroundImage: AssetImage(
                          song['image'] ?? 'assets/music_placeholder.jpg',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    song['title'] ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    song['artist'] ?? '',
                    style: const TextStyle(fontSize: 20, color: Colors.white70),
                  ),
                  Text(
                    song['genre'] ?? '',
                    style: const TextStyle(fontSize: 16, color: Colors.white60),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Kontrol Lagu
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: previousSong,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color.fromARGB(255, 5, 13, 67),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.skip_previous),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: togglePlay,
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        label: Text(isPlaying ? 'Pause' : 'Play'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color.fromARGB(255, 5, 13, 67),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: nextSong,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color.fromARGB(255, 5, 13, 67),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                        ),
                        child: const Icon(Icons.skip_next),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Panel Info Geser dari Kanan
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            right: showInfo ? 0 : -250,
            top: 0,
            bottom: 0,
            width: 250,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(-5, 0),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Song Info',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 5, 13, 67),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),

                  // Album
                  const Text(
                    'Album:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(song['album'] ?? 'Unknown', textAlign: TextAlign.center),
                  const SizedBox(height: 16),

                  // Year
                  const Text(
                    'Year:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(song['year'] ?? 'Unknown', textAlign: TextAlign.center),
                  const SizedBox(height: 16),

                  // Songwriter
                  const Text(
                    'Songwriter:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    song['songwriter'] ?? 'Unknown',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Composer
                  const Text(
                    'Composer:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    song['composer'] ?? 'Unknown',
                    textAlign: TextAlign.center,
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        setState(() {
                          showInfo = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
