import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MoviePlayer extends StatefulWidget {
  const MoviePlayer({super.key});

  @override
  State<MoviePlayer> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<MoviePlayer> {
  late YoutubePlayerController _controller;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      final args = ModalRoute.of(context)!.settings.arguments
      as Map<String, dynamic>;

      final String trailerId = args["trailerId"] ?? "";

      _controller = YoutubePlayerController(
        initialVideoId: trailerId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          controlsVisibleAtStart: true,
          enableCaption: true,
          hideControls: false,
        ),
      );

      _isInit = true;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
        ),
      ),
    );
  }
}
