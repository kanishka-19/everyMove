import 'package:flutter/material.dart';
import 'package:everymove/main.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayVideo extends StatefulWidget {
  late String  url;
  static const String id= '/video';
  PlayVideo({required this.url});
  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
 late YoutubePlayerController controller;
 Future<void>? initializeVideoPlayerFuture;
 @override
  void initState() {
    controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(this.widget.url)!,
        flags: YoutubePlayerFlags(
        autoPlay: true,
          hideControls: false,
          controlsVisibleAtStart: true,
        mute: false,));

    super.initState();
  }

  @override
  void dispose() {
   controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: YoutubePlayer(
          controller: controller,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.white,
          onReady: () {
            print('Player is ready.');
          },
        ),
      ),
    );
      //     FutureBuilder(
    //       future: initializeVideoPlayerFuture,
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.done) {
    //           return AspectRatio(
    //             aspectRatio: controller.value.aspectRatio,
    //             child: VideoPlayer(controller),
    //           );
    //         } else {
    //           return Center(
    //             child: CircularProgressIndicator(backgroundColor: Colors.blue,
    //             ),
    //           );
    //         }
    //       }
    // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            if(controller.value.isPlaying){
              controller.pause();
            }else{
              controller.play();
            }
          });
        },
        child: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),

        //   controller.value.isInitialized
    //       ? AspectRatio(
    //     aspectRatio: controller.value.aspectRatio,
    //     child: VideoPlayer(controller),
    //   )
    //       : CircularProgressIndicator(),
     );
  }
}
