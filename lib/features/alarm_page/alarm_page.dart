import 'package:flutter/material.dart';
import 'package:pododoro/utilities.dart' show AlarmAction;
import 'package:video_player/video_player.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  late VideoPlayerController _controller;
  late Future _controllerFuture;

  @override void initState() {
    super.initState();

    _controller = VideoPlayerController.asset("assets/videos/bark.mp4");
    _controller.setLooping(true);

    _controller.initialize().then((_) => setState(() {}));
    _controllerFuture = _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 212, 131, 9),
      body: FutureBuilder(
        future: _controllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, AlarmAction.startNextTimer);
                          },
                          child: Text("Start next timer"),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, AlarmAction.returnHome);
                        },
                        child: Text("Return home"),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}