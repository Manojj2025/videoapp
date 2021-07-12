import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_border_style.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_position.dart';
import 'package:subtitle_wrapper_package/data/models/style/subtitle_style.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';

import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:subtitle_wrapper_package/subtitle_wrapper_package.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Video app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Roboto",
        canvasColor: Colors.transparent,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _controller1;
  late SubtitleController _subtitleController;
  late Animation<double> _animation1;
  bool show = true;
  double videoContainerRatio = 0.5;
  late Orientation target;
  Timer? t;

  @override
  void initState() {
    super.initState();
    _subtitleController = SubtitleController(
      subtitleUrl: "https://pastebin.com/raw/ZWWAL7fK",
      subtitleType: SubtitleType.webvtt,
    );

    _controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(_controller1);
    _controller1.forward();
    _controller = VideoPlayerController.network(
        'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4')
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    _controller.addListener(() {
      setState(() {});
    });

    return Scaffold(
      body: SafeArea(
        child: !_controller.value.isInitialized
            ? Container(
                height: MediaQuery.of(context).size.width / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
              )
            : Stack(
                alignment: isPortrait ? Alignment.topCenter : Alignment.center,
                children: [
                  SubTitleWrapper(
                    videoPlayerController: _controller,
                    subtitleController: _subtitleController,
                    subtitleStyle: SubtitleStyle(
                      textColor: Colors.white,
                      borderStyle: SubtitleBorderStyle(color: Colors.black),
                      position: SubtitlePosition(
                        bottom: isPortrait ? 10 : 50,
                      ),
                      hasBorder: true,
                    ),
                    videoChild: Transform.scale(
                      scale: 1.21,
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation1,
                    child: GestureDetector(
                      onTap: () => visibilityControl(),
                      child: Container(
                        height: isPortrait
                            ? MediaQuery.of(context).size.height / 3.2
                            : MediaQuery.of(context).size.height,
                        color: Colors.black54,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: !isPortrait
                                  ? InkWell(
                                      onTap: () {
                                        information(isPortrait);
                                      },
                                      child: Image.asset(
                                        'assets/cast.png',
                                        height: 35,
                                        width: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Container(),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.subtitles,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setting(isPortrait);
                                    },
                                    child: Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        visibilityControl();
                                      },
                                      icon: Icon(
                                        Icons.skip_previous,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      child: _controller.value.isBuffering
                                          ? CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.red),
                                            )
                                          : IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  visibilityControl(
                                                      playpause: true);
                                                  _controller.value.isPlaying
                                                      ? _controller.pause()
                                                      : _controller.play();
                                                });
                                              },
                                              icon: Icon(
                                                _controller.value.isPlaying
                                                    ? Icons.pause
                                                    : Icons.play_arrow,
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        visibilityControl();
                                      },
                                      icon: Icon(
                                        Icons.skip_next,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: !isPortrait
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.13
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.3,
                                        child: ProgressBar(
                                          buffered: _controller
                                                      .value.buffered.length ==
                                                  0
                                              ? Duration.zero
                                              : _controller
                                                  .value.buffered[0].end,
                                          progress: _controller.value.position,
                                          total: _controller.value.duration,
                                          progressBarColor: Colors.red,
                                          baseBarColor:
                                              Colors.white.withOpacity(0.14),
                                          bufferedBarColor:
                                              Colors.white.withOpacity(0.4),
                                          thumbColor: Colors.red,
                                          barHeight: 3.0,
                                          thumbRadius: 5.0,
                                          timeLabelTextStyle:
                                              TextStyle(color: Colors.white),
                                          onSeek: (duration) {
                                            _controller.seekTo(duration);
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (isPortrait) {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.landscapeLeft,
                                              DeviceOrientation.landscapeRight
                                            ]);
                                          } else {
                                            SystemChrome
                                                .setPreferredOrientations([
                                              DeviceOrientation.portraitDown,
                                              DeviceOrientation.portraitUp
                                            ]);
                                          }
                                        },
                                        child: Icon(
                                          Icons.fit_screen,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          // width: MediaQuery.of(context).size.width / 3.2),
                          child: GestureDetector(
                            onDoubleTap: () {
                              Duration oldposition = _controller.value.position;
                              int seconds = oldposition.inSeconds - 10;
                              Duration newposition = Duration(seconds: seconds);
                              _controller.seekTo(newposition);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 4.4,
                      ),
                      Expanded(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          child: GestureDetector(
                            onDoubleTap: () {
                              Duration oldposition = _controller.value.position;
                              int seconds = oldposition.inSeconds + 10;
                              Duration newposition = Duration(seconds: seconds);
                              _controller.seekTo(newposition);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  double getScale() {
    double videoRatio = _controller.value.aspectRatio;

    if (videoRatio < 1) {
      ///for tall videos, we just return the inverse of the controller aspect ratio
      return 1 / videoRatio;
    } else {
      ///for wide videos, divide the video AR by the fixed container AR
      ///so that the video does not over scale

      return videoRatio / videoContainerRatio;
    }
  }

  visibilityControl({playpause: false}) {
    if (t != null) {
      t?.cancel();
    }
    _controller1.duration = Duration(milliseconds: 500);
    if (show) {
      if (playpause) {
        t = Timer.periodic(const Duration(seconds: 3), (timer) {
          _controller1.reverse();
          t?.cancel();
        });
      } else {
        _controller1.reverse();
      }
      show = false;
    } else {
      _controller1.forward();
      show = true;
      t = Timer.periodic(const Duration(seconds: 3), (timer) {
        _controller1.reverse();
        t?.cancel();
        show = false;
      });

      // Future.delayed(Duration(seconds: 5), () {
      //   print(5);
      //   _controller1.reverse();
      //   show = false;
      // });
    }
  }

  void information(isPortrait) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (_, controller) {
            return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0.9),
                  Colors.black,
                ],
              )),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: GridView.builder(
                  itemCount: 30,
                  controller: controller,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 2,
                      childAspectRatio: 0.92),
                  itemBuilder: (c, i) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Image.asset(
                            'assets/cast.png',
                            height: 70,
                            width: 70,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'maan ji sir',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void setting(isPortrait) {
    showModalBottomSheet(
      //isDismissible: true,
      // enableDrag: true,
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return Container(
          height: 240,
          color: Colors.white,
          child: Column(children: [
            ListTile(
                dense: false,
                leading: Icon(Icons.turned_in_rounded),
                title: Text('Add to list'),
                onTap: () {}),
            ListTile(
                dense: false,
                leading: Icon(Icons.audiotrack),
                title: Text('Audio'),
                onTap: () {
                  Navigator.pop(context);
                  subtitle(isPortrait, false);
                }),
            ListTile(
                dense: false,
                leading: Icon(Icons.closed_caption_off),
                title: Text('Sub title'),
                onTap: () {
                  Navigator.pop(context);
                  subtitle(isPortrait, true);
                }),
            ListTile(
                dense: false,
                leading: Icon(Icons.audiotrack),
                title: Text('Video Quality >'),
                onTap: () {
                  Navigator.pop(context);
                  video(isPortrait);
                }),
          ]),
        );
      },
    );
  }

  void video(isPortrait) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait
              ? false
              : true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
            expand: isPortrait =
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? false
                    : true,
            builder: (_, controller) {
              return Container(
                color: Colors.white,
                child: ListView(controller: controller, children: [
                  ListTile(
                      dense: false,
                      title: Center(child: Text('4k')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('2k')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('1080p')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('720p')),
                      onTap: () {}),
                  ListTile(
                      // dense: false,
                      title: Center(child: Text('480p')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('360p')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('240p')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Auto')),
                      onTap: () {}),
                ]),
              );
            });
      },
    );
  }

  subtitle(isPortrait, on) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: isPortrait =
          MediaQuery.of(context).orientation == Orientation.portrait
              ? false
              : true, // set this to true
      builder: (_) {
        return DraggableScrollableSheet(
            expand: isPortrait =
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? false
                    : true,
            builder: (_, controller) {
              return Container(
                color: Colors.white,
                child: ListView(controller: controller, children: [
                  on
                      ? ListTile(
                          dense: false,
                          title: Center(child: Text('On')),
                          onTap: () {})
                      : Container(),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Hindi')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('English')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Tamil')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Gujarati')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Rajasthani')),
                      onTap: () {}),
                  ListTile(
                      dense: false,
                      title: Center(child: Text('Marathi')),
                      onTap: () {}),
                ]),
              );
            });
      },
    );
  }
}
