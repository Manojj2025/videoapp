import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter/services.dart';

import 'package:video_player/video_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([
    SystemUiOverlay.bottom,
    //This line is used for showing the bottom bar
  ]);

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
  late Animation<double> _animation1;
  bool show = true;
  late bool isPortrait;
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIOverlays([
    //   SystemUiOverlay.bottom, //This line is used for showing the bottom bar
    // ]);

    _controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
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
    // bool _lights = false;
    bool addlist = true;

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
            : AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              //  color: Colors.black,
                              height: MediaQuery.of(context).size.height,
                              // width: MediaQuery.of(context).size.width / 3.2),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4.4,
                          ),
                          Expanded(
                            child: Container(
                              //  color: Colors.black,
                              height: MediaQuery.of(context).size.height,
                            ),
                          )
                        ],
                      ),
                    ),
                    FadeTransition(
                      opacity: _animation1,
                      child: GestureDetector(
                        onTap: () => visibilityControl(),
                        child: Container(
                          color: Colors.black54,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: !isPortrait
                                    ? InkWell(
                                        onTap: () {
                                          information();
                                        },
                                        child: Image.asset(
                                          'assets/cast.png',
                                          height: 35,
                                          width: 30,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Container(
                                        height: 10,
                                        width: 10,
                                      ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(18.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Switch(
                                    //     value: _lights,
                                    //     onChanged: (bool value) {
                                    //       setState(() {
                                    //         _lights = value;
                                    //       });
                                    //     }),
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
                                        setting();
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
                                  //  color: Colors.black,
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          visibilityControl();
                                          // _controller.value.isPlaying
                                          //     ? _controller.pause()
                                          //     : _controller.play();
                                        },
                                        icon: Icon(
                                          // _controller.value.isPlaying
                                          //     ? Icons.pause
                                          //     : Icons.skip_previous,
                                          Icons.skip_previous,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        child: _controller.value.isBuffering
                                            ? CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.red),
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    visibilityControl();
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
                                          // _controller.value.isPlaying
                                          //     ? _controller.pause()
                                          //     : _controller.play();
                                        },
                                        icon: Icon(
                                          // _controller.value.isPlaying
                                          //     ? Icons.pause
                                          //     : Icons.skip_previous,
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
                                    child: ProgressBar(
                                      buffered:
                                          _controller.value.buffered.length == 0
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  visibilityControl() {
    _controller1.duration = Duration(milliseconds: 200);
    if (show) {
      show = false;

      _controller1.reverse();
    } else {
      show = true;
      _controller1.forward();

      Future.delayed(Duration(seconds: 5), () {
        show = false;

        _controller1.reverse();
      });
    }
  }

  void information() {
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

  void setting() {
    showModalBottomSheet(
      //isDismissible: true,
      // enableDrag: true,
      context: context,
      isScrollControlled: true, // set this to true
      builder: (_) {
        return Container(
          height: 300,
          color: Colors.white,
          child: Column(children: [
            ListTile(
                dense: false,
                leading: Icon(Icons.turned_in_rounded),
                title: Text('Add to list'),
                onTap: () {}),
            ListTile(
                dense: false,
                leading: Icon(Icons.fit_screen),
                title: Text('Fit to screen'),
                onTap: () {}),
            ListTile(
                dense: false,
                leading: Icon(Icons.audiotrack),
                title: Text('Audio'),
                onTap: () {
                  Navigator.pop(context);
                  subtitle();
                }),
            ListTile(
                dense: false,
                leading: Icon(Icons.closed_caption_off),
                title: Text('Sub title'),
                onTap: () {
                  Navigator.pop(context);
                  subtitle();
                }),
            ListTile(
                dense: false,
                leading: Icon(Icons.audiotrack),
                title: Text('Video Quality >'),
                onTap: () {
                  Navigator.pop(context);
                  video();
                }),
          ]),
        );
      },
    );
  }

  void video() {
    showModalBottomSheet(
      //  enableDrag: true,

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
                //height: 450,
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

  subtitle() {
    // bool value = true;
    showModalBottomSheet(
      //  enableDrag: true,

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
                //height: 450,
                color: Colors.white,
                child: ListView(controller: controller, children: [
                  ListTile(
                      dense: false,
                      title: Center(child: Text('On')),
                      onTap: () {}),
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
                      // dense: false,
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
    // bool _lights = false;

    // SimpleDialog(
    //   backgroundColor: Colors.white,
    //   title: const Text('On/Off'),
    //   children: <Widget>[
    //     SimpleDialogOption(
    //       onPressed: () {},
    //       child: SwitchListTile(
    //         value: _lights,
    //         onChanged: (bool value) {
    //           setState(() {
    //             _lights = value;
    //           });
    //         },
    //         secondary: const Icon(Icons.lightbulb_outline),
    //       ),
    //     ),
    //   ],
    // );
  }
}
