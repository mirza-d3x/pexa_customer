import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlaying extends StatefulWidget {
  const VideoPlaying({super.key});

  @override
  State<VideoPlaying> createState() => _VideoPlayingState();
}

class _VideoPlayingState extends State<VideoPlaying> {
  final urlone ="https://www.youtube.com/watch?v=saD9Ks0gJBA";
  final urltwo ="https://www.youtube.com/watch?v=wDt9cI8BYI0&t=2s";
   YoutubePlayerController? _controllerone;
  YoutubePlayerController? _controllertwo;
  @override
  void initState() {
    // TODO: implement initState
    final VideoIdone=YoutubePlayer.convertUrlToId(urlone);
    _controllerone=YoutubePlayerController(
      initialVideoId: VideoIdone!,
      flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: true,
    ),
    );
    final VideoIdtwo=YoutubePlayer.convertUrlToId(urltwo);
    _controllertwo=YoutubePlayerController(
      initialVideoId: VideoIdtwo!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage("assets/image/Car Wash in Bike Unit.jpg")),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(onTap: ()async{
              {
                const url = "https://www.youtube.com/watch?v=JrhOrQENBvY";

                if (await canLaunchUrlString (url)
              ) {
              await launchUrlString(url);
              } else {
              throw 'Could not launch $url';
              }
            }
            },child: const Icon(Icons.play_circle,size: 35,color: Colors.white),)
            /*YoutubePlayer(
              thumbnail: DecoratedBox(decoration: BoxDecoration()),
              controller: _controllerone!,
              showVideoProgressIndicator: true,
              bottomActions: [

              ],

            ),*/
          ),
        ),
        const SizedBox(width: 10,),
        Expanded(
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage("assets/image/maxresdefault.jpg")),
              borderRadius: BorderRadius.circular(20),
            ),
            child: GestureDetector(onTap: ()async{
              {
                const url = "https://www.youtube.com/watch?v=XZV7kbgU5sk";

                if (await canLaunchUrlString (url)
              ) {
              await launchUrlString(url);
              } else {
              throw 'Could not launch $url';
              }
            }
            },child: const Icon(Icons.play_circle,size: 35,color: Colors.white),)
            /*YoutubePlayer(
              thumbnail: DecoratedBox(decoration: BoxDecoration()),
              controller: _controllertwo!,
              showVideoProgressIndicator: true,
              bottomActions: [

              ],
            ),*/
          ),
        ),
      ],
    );


    /*Row(
      children: [
        Expanded(
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: FloatingActionButton(
              heroTag: "button 1",
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            height: 100,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Colors.black38, borderRadius: BorderRadius.circular(10)),
            child: FloatingActionButton(
              heroTag: "button 2",
              elevation: 0,
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: Icon(
                Icons.play_circle_outline,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
        ),
      ],
    );*/
  }
}
