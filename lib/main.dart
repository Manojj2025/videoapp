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
  final double a = 15.0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom, //This line is used for showing the bottom bar
    ]);

    _controller1 =
        AnimationController(vsync: this, duration: Duration(milliseconds: 0));
    _animation1 = Tween(begin: 0.0, end: 1.0).animate(_controller1);
    _controller1.forward();
    _controller = VideoPlayerController.network(
        'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4')
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
    _controller.addListener(() {
      setState(() {});
    });
    return Scaffold(
        body: Container(
      child: (AspectRatio(
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
                      Column(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.all(18.0),
                          //   child: Container(
                          //     child: PopupMenuButton(
                          //       color: Colors.transparent,
                          //       elevation: 0.0,
                          //       offset: Offset(20, -50),
                          //       tooltip: 'information',
                          //       child: Icon(
                          //         Icons.info,
                          //         color: Colors.white,
                          //       ),
                          //       itemBuilder: (context) => [
                          //         PopupMenuItem(
                          //             child: Column(
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Text('Cast',
                          //                     style: TextStyle(
                          //                         fontWeight: FontWeight.bold,
                          //                         color: Colors.white)),
                          //                 Icon(
                          //                   Icons.arrow_right_alt,
                          //                   color: Colors.white,
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 PopupMenuButton(
                          //                   color: Colors.transparent,
                          //                   elevation: 0.0,
                          //                   offset: Offset(70, -22),
                          //                   child: Text(
                          //                     'Genre',
                          //                     style: TextStyle(
                          //                         color: Colors.white),
                          //                   ),
                          //                   itemBuilder: (context) => [
                          //                     PopupMenuItem(
                          //                         child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         Text(
                          //                             'Comedy,drama,funny,action-Movie',
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.bold,
                          //                                 fontSize: 12,
                          //                                 color: Colors
                          //                                     .grey[600])),
                          //                       ],
                          //                     )),
                          //                   ],
                          //                 ),
                          //                 // Text(
                          //                 //   'Genre',
                          //                 //   style: TextStyle(
                          //                 //       fontWeight: FontWeight.bold,
                          //                 //       color: Colors.white),
                          //                 // ),
                          //                 Icon(
                          //                   Icons.arrow_right_alt,
                          //                   color: Colors.white,
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 PopupMenuButton(
                          //                   color: Colors.transparent,
                          //                   elevation: 0.0,
                          //                   offset: Offset(80, -22),
                          //                   child: Text(
                          //                     'Langauge',
                          //                     style: TextStyle(
                          //                         color: Colors.white),
                          //                   ),
                          //                   itemBuilder: (context) => [
                          //                     PopupMenuItem(
                          //                         child: Column(
                          //                       mainAxisAlignment:
                          //                           MainAxisAlignment.start,
                          //                       children: [
                          //                         Text(
                          //                             'Hindi/English/Tamil/Rajasthani',
                          //                             style: TextStyle(
                          //                                 fontWeight:
                          //                                     FontWeight.bold,
                          //                                 fontSize: 12,
                          //                                 color: Colors
                          //                                     .grey[600])),
                          //                       ],
                          //                     )),
                          //                   ],
                          //                 ),
                          //                 Icon(
                          //                   Icons.arrow_right_alt,
                          //                   color: Colors.white,
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         )),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(18.0),
                          //   child: Container(
                          //     child: PopupMenuButton(
                          //       color: Colors.transparent,
                          //       elevation: 0.0,
                          //       offset: Offset(0, -20),
                          //       tooltip: 'Setting',
                          //       child: Icon(
                          //         Icons.settings,
                          //         color: Colors.white,
                          //       ),
                          //       itemBuilder: (context) => [
                          //         PopupMenuItem(
                          //             child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.turned_in_rounded,
                          //                   color: Colors.white,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   'Add tp list',
                          //                   style: TextStyle(
                          //                     color: Colors.white,
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.fit_screen,
                          //                   color: Colors.white,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   'Fit to screen',
                          //                   style:
                          //                       TextStyle(color: Colors.white),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.audiotrack,
                          //                   color: Colors.white,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 Text(
                          //                   'Audio',
                          //                   style:
                          //                       TextStyle(color: Colors.white),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             Row(
                          //               children: [
                          //                 Icon(
                          //                   Icons.closed_caption_off,
                          //                   color: Colors.white,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 5,
                          //                 ),
                          //                 SizedBox(
                          //                   height: a,
                          //                 ),
                          //                 Text(
                          //                   'Sub title',
                          //                   style:
                          //                       TextStyle(color: Colors.white),
                          //                 ),
                          //               ],
                          //             ),
                          //             SizedBox(
                          //               height: a,
                          //             ),
                          //             PopupMenuButton(
                          //               color: Colors.transparent,
                          //               elevation: 0.0,
                          //               offset: Offset(-180, -130),
                          //               child: Text(
                          //                 'Video Quality >',
                          //                 style: TextStyle(color: Colors.white),
                          //               ),
                          //               itemBuilder: (context) => [
                          //                 PopupMenuItem(
                          //                     child: Column(
                          //                   mainAxisAlignment:
                          //                       MainAxisAlignment.start,
                          //                   children: [
                          //                     Text('4K',
                          //                         style: TextStyle(
                          //                             fontWeight:
                          //                                 FontWeight.bold,
                          //                             color: Colors.white)),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       '2K',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       '1080p',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       '720p',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       '480p',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       '360p',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                     SizedBox(
                          //                       height: a,
                          //                     ),
                          //                     Text(
                          //                       'Auto ',
                          //                       style: TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                           color: Colors.white),
                          //                     ),
                          //                   ],
                          //                 )),
                          //               ],
                          //             ),
                          //           ],
                          //         )),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Center(
                              child: Container(
                                //  color: Colors.black,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                  AlwaysStoppedAnimation<Color>(
                                                      Colors.red),
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
                            Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(50.0),
                                  child: Container(
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
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    ));
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
      show2();
    }
  }

  show2() {
    Container(
      color: Colors.transparent,
    );
  }
}
