import 'dart:io';

import 'package:findmyanime/components/preview_canvas.dart';
import 'package:findmyanime/components/result_list_view.dart';
import 'package:findmyanime/components/submit_form.dart';
import 'package:findmyanime/pages/about_page.dart';
import 'package:findmyanime/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/all.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

import 'upload_image_dialog.dart';

class Homepage extends ConsumerWidget {
  const Homepage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _hasResult = watch(hasResultProvider).state;
    final _imageFile = watch(imageFileProvider).state;

    var noImage = GestureDetector(
      onTap: () => getFromGallery(context),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.panorama,
              size: 80,
            ),
            Text("Upload Your Anime Screenshot")
          ],
        ),
      ),
    );

    var showImage = Container(
      decoration: BoxDecoration(
        color: Colors.white54,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: FileImage(
            _imageFile == null ? File("") : _imageFile,
          ),
        ),
      ),
      // child: Image(
      //   fit: BoxFit.fitHeight,
      //   image: FileImage(
      //     _imageFile == null ? File("") : _imageFile,
      //   ),
      // ),
    );

    var imageCanvas = Container(
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                Container(
                  // decoration: BoxDecoration(color: Colors.white70),
                  child: _imageFile != null ? showImage : noImage,
                ),
                _hasResult ? PreviewCanvas() : Container(),
                // UploadFAB()
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Image.asset(
            "assets/images/title_Asset_xxhdpi.png",
            scale: 1,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () {
            if (_hasResult) {
              context.read(hasResultProvider).state = false;
              context.read(imageFileProvider).state = null;
            } else {
              SystemNavigator.pop();
            }
            // return
          },
          child: Stack(
            children: [
              _hasResult ? ResultListViewManual() : Container(),
              AnimatedContainer(
                duration: Duration(milliseconds: _hasResult ? 600 : 350),
                height: _hasResult
                    ? MediaQuery.of(context).size.height * 0.4
                    : MediaQuery.of(context).size.height *
                        0.85, //mediaquery - 10px
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 2.0,
                      spreadRadius: 2.0,
                      offset: Offset(0.0, 4.0),
                    ),
                  ],
                ),
                child: Center(
                  child: FractionallySizedBox(
                    heightFactor: _hasResult ? 1 : 0.9,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 4.0,
                            ),
                            child: imageCanvas,
                          ),
                        ),
                        // SizedBox(height: 4),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: _hasResult
                                          ? AnilistIdLink()
                                          : AnilistIdFilter(),
                                    ), // Padding(
                                    //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    //   child: OutlineButton(
                                    //     child: Text("anilist/anime/12345"),
                                    //     onPressed: () {},
                                    //   ),
                                    // ),
                                  ),
                                  UploadFAB(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        !_hasResult
                            ? Expanded(
                                flex: 3,
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   color: Colors.blue,
                                  // ),
                                  alignment: Alignment(0.0, -0.9),
                                  child: FindAnimeButton(imageFile: _imageFile),
                                ),
                              )
                            : Container(
                                color: Colors.green,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
        // Column(
        //   children: <Widget>[
        //     Expanded(
        //       flex: 3,
        //       child: Container(
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //         ),
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(
        //             horizontal: 10.0,
        //             vertical: 4.0,
        //           ),
        //           child: imageCanvas,
        //         ),
        //       ),
        //     ),

        //     // SizedBox(height: 4),
        //     Expanded(
        //       flex: 5,
        //       child: Stack(
        //         children: [
        //           _hasResult ? ResultListViewManual() : Container(),
        //           ElasticBottomBar(),
        //           !_hasResult
        //               ? FindAnimeButton(imageFile: _imageFile)
        //               : Container(),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}

class AnilistIdFilter extends StatelessWidget {
  const AnilistIdFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        decoration: InputDecoration(
          fillColor: Colors.white,
          hintText: "Filter Anilist ID",
          suffixText: "...",
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class AnilistIdLink extends ConsumerWidget {
  const AnilistIdLink({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _anilistId = watch(linkProvider).state;

    _launchURL() async {
      var url = 'https://anilist.co/anime/' + _anilistId;
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Opacity(
      opacity: 0.5,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(),
            borderRadius: BorderRadius.circular(5)),
        child: GestureDetector(
          onTap: _launchURL,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "anilist.co/anime/" + _anilistId,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ElasticBottomBar extends ConsumerWidget {
  const ElasticBottomBar({
    Key key,
  }) : super(key: key);

  // var anilistIdFilter = Container(
  //     color: Colors.white,
  //     child: TextField(
  //       decoration: InputDecoration(
  //         fillColor: Colors.white,
  //         hintText: "Filter Anilist ID",
  //         suffixText: "...",
  //         border: const OutlineInputBorder(),
  //       ),
  //     ),
  //   );

  //   var anilistIdLink = Container(
  //     height: 60,
  //     decoration: BoxDecoration(
  //         color: Colors.white,
  //         border: Border.all(),
  //         borderRadius: BorderRadius.circular(0.5)),
  //     child: GestureDetector(
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(
  //           horizontal: 12.0,
  //           vertical: 12.0,
  //         ),
  //         child: Row(
  //           children: [
  //             Expanded(
  //               child: Text(
  //                 "anilist.co/anime/98444",
  //                 style: TextStyle(fontSize: 16),
  //               ),
  //             ),
  //             Icon(Icons.arrow_right_alt),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _isSuccess = watch(isSuccessProvider).state;
    final _hasResult = watch(hasResultProvider).state;

    return AnimatedContainer(
      alignment: Alignment(0.0, -0.5),
      height: _isSuccess ? 80 : 400,
      duration: Duration(seconds: 1),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(35),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 2.0,
            spreadRadius: 2.0,
            offset: Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: _hasResult ? AnilistIdLink() : AnilistIdFilter(),
                ), // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                //   child: OutlineButton(
                //     child: Text("anilist/anime/12345"),
                //     onPressed: () {},
                //   ),
                // ),
              ),
              UploadFAB(),
            ],
          ),
        ),
      ),
    );
  }
}

class UploadFAB extends StatelessWidget {
  const UploadFAB({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange[400],
        borderRadius: BorderRadius.circular(
          50,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 1.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 1.0),
          ),
        ],
      ),
      child: InkWell(
        splashColor: Colors.red, // inkwell color
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.white,
          ),
        ),
        onTap: () {
          getFromGallery(context);
          // showDialog(
          //   context: context,
          //   builder: (BuildContext context) {
          //     return UploadModal();
          //   },
          // );
        },
      ),
    );
  }
}

class FindAnimeButton extends ConsumerWidget {
  const FindAnimeButton({
    Key key,
    @required File imageFile,
  })  : _imageFile = imageFile,
        super(key: key);

  final File _imageFile;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _btnController = watch(btnControllerProvider).state;

    return SizedBox(
      height: 70,
      width: 300,
      child: RoundedLoadingButton(
        color: Colors.orange[600],
        successColor: Colors.green,
        controller: _btnController,
        onPressed: () async {
          _imageFile != null
              ? await traceImage(context, _imageFile)
              : traceImageFailed(context, "Please select the image first!");
        },
        width: 400,
        height: 80,
        child: Text(
          "Find My Anime!",
          style: GoogleFonts.exo2(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
              letterSpacing: .5,
            ),
          ),
        ),
      ),
    );
  }
}
