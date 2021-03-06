import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecogoals/pages/details.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:sliding_sheet/sliding_sheet.dart';

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:path/path.dart' as Path;

class InfoPage extends StatefulWidget {
  final Map<String, dynamic> params;
  final String name;

  InfoPage({Key key, this.params, this.name}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

//TODO add some mods for data before passing here

class _InfoPageState extends State<InfoPage> {
  PageController _pageController;
  double _progress = 0;
  double _multiple;
  double _opacity;
  double _opacityTitleAppBar;

  bool fbloaded = true;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController
  }

  String footprint = "Loading";

  String description = "Loading";

  double interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) return 1.0;
    if (progress < lower) return 0.0;

    return ((progress - lower) / (upper - lower)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    int itemnum = 01;
    String category = "Item"; //may not need this
    //_progress = 0;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: Stack(
                children: [
                  AppBar(
                    centerTitle: true,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      Stack(
                        children: [
                          IconButton(
                            icon: Icon(Icons.favorite_border),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.12 -
                        _progress *
                            (MediaQuery.of(context).size.height * 0.060),
                    left: 20 +
                        _progress *
                            (MediaQuery.of(context).size.height * 0.060),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontFamily: 'Google',
                          fontSize: 38 -
                              _progress *
                                  (MediaQuery.of(context).size.height * 0.011),
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .16,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromARGB(80, 255, 255, 255)),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Text(
                                  category,
                                  style: TextStyle(
                                      fontFamily: 'Google',
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Text(
                              "#00" + itemnum.toString(),
                              style: TextStyle(
                                  fontFamily: 'Google',
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 200,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 13, 13, 13),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.network(widget.params["images"][0]).image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SlidingSheet(
              listener: (state) {
                setState(() {
                  _progress = state.progress;
                  _multiple = 1 - interval(0.6, 0.87, _progress);
                  _opacity = _multiple;
                  _opacityTitleAppBar = interval(0.6, 0.87, _progress);
                });
              },
              elevation: 0,
              cornerRadius: 40,
              snapSpec: const SnapSpec(
                snap: true,
                snappings: [0.1, .87, 1.00],
                positioning: SnapPositioning.relativeToAvailableSpace,
              ),
              builder: (context, state) {
                return Container(
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height * .12,
                  child: fbloaded
                      ? Details(item: widget.name, params: widget.params)
                      : Center(child: CircularProgressIndicator()),
                );
              },
              headerBuilder: (context, state) {
                return Container(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Center(
                    child: Icon(
                      Icons.swap_vert,
                      color: Colors.black,
                      size: 30.0,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
