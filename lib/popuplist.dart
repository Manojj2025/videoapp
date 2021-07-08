import 'package:flutter/material.dart';

class LabeledSwitch extends StatelessWidget {
  const LabeledSwitch({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Switch(
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return LabeledSwitch(
      label: 'This is the label text',
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      value: _isSelected,
      onChanged: (bool newValue) {
        setState(() {
          _isSelected = newValue;
        });
      },
    );
  }
}

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