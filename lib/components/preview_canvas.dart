import 'package:findmyanime/components/result_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

final urlProvider = StateProvider<String>((ref) {
  print("urlProvider hereeeeeee");
  final result = ref.watch(selectedResultProvider).state.docs;
  if (result.isAdult) return "";
  final _uriPreviewVideo = "https://media.trace.moe/video";
  final _uriPreviewImage = "https://media.trace.moe/Image";

  final uriEncodeComponent = Uri.encodeComponent(result.filename);

  var url =
      "$_uriPreviewVideo/${result.anilistId}/$uriEncodeComponent?t=${result.at}&token=${result.tokenthumb}&mute";
  return url;
});

class PreviewCanvas extends ConsumerWidget {
  const PreviewCanvas({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final url = watch(urlProvider).state;

    return Container(
      child: url != "" ? VideoPlayerScreen(url: url) : NSFWImage(),
    );
  }
}

class NSFWImage extends StatelessWidget {
  const NSFWImage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        color: Colors.white,
        child: Center(
          child: Image(
            image: AssetImage("assets/images/NSFW.jpg"),
          ),
        ),
      ),
    );
  }
}

class VideoPlayerScreen extends StatefulWidget {
  final String url;

  const VideoPlayerScreen({
    Key key,
    @required this.url,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    print("ini pas nyampe");
    print(widget.url);
    print(widget.url.runtimeType);

    initPlayer();

    super.initState();
  }

  void initPlayer() {
    _controller = VideoPlayerController.network(
      widget.url,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    _controller.play();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(VideoPlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.url != oldWidget.url) {
      print("url changed!");
      print(widget.url);
      print(oldWidget.url);
      _controller.dispose();
      initPlayer();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("rebuild UI previewCanvas");
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          print("done");
          print(_controller.dataSource);
          // If the VideoPlayerController has finished initialization, use
          // the data it provides to limit the aspect ratio of the video.
          return VideoPlayer(_controller);
        } else {
          print("not doneee");
          // If the VideoPlayerController is still initializing, show a
          // loading spinner.
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

// class VideoPlayerScreenStateless extends StatelessWidget {
//   final String url;

//   const VideoPlayerScreenStateless({
//     Key key,
//     @required this.url,
//   }) : super(key: key);

//   final VideoPlayerController _controller = VideoPlayerController.network(url);
//   Future<void> _initializeVideoPlayerFuture;

//   @override
//   Widget build(BuildContext context) {
//     print("rebuild UI previewCanvas");
//     return FutureBuilder(
//       future: _initializeVideoPlayerFuture,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           print("done");
//           print(_controller.dataSource);
//           // If the VideoPlayerController has finished initialization, use
//           // the data it provides to limit the aspect ratio of the video.
//           return VideoPlayer(_controller);
//         } else {
//           print("not doneee");
//           // If the VideoPlayerController is still initializing, show a
//           // loading spinner.
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
