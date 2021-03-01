import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:findmyanime/components/result_list_view.dart';
import 'package:findmyanime/models/tracemodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:hooks_riverpod/all.dart';
import 'package:findmyanime/providers/home_page_provider.dart';
import 'package:image_picker/image_picker.dart';

final uri = "https://trace.moe/api/search";
final uriPreviewVideo = "https://media.trace.moe/video";
final uriPreviewImage = "https://media.trace.moe/Image";

Future<void> traceImage(BuildContext context, File imageFile) async {
  final _response = await http.post(
    uri,
    body: {
      'image': imageFile != null
          ? 'data:image/png;base64,' + base64Encode(imageFile.readAsBytesSync())
          : '',
    },
  ).timeout(Duration(seconds: 30), onTimeout: () {
    traceImageFailed(context, "Failed to connect. Timeout exceed");
    return;
  });
  if (_response.statusCode == 200) {
    final _responseJson = json.decode(_response.body);
    print(_response.body);
    TraceModel _result = TraceModel.fromJson(_responseJson);
    context.read(btnControllerProvider).state.success();
    Timer(Duration(seconds: 1), () {
      context.read(resultProvider).state = _result;
      context.read(selectedResultProvider).state =
          SelectedResult(docs: _result.docs[0], index: 0);
      context.read(hasResultProvider).state = true;
    });
    return;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    traceImageFailed(context, "Failed to connect");
    return;
  }
}

// Future<TraceModel> submitForm(File _image) async {
//   final _response = await http.post(
//     uri,
//     body: {
//       'image': _image != null
//           ? 'data:image/png;base64,' + base64Encode(_image.readAsBytesSync())
//           : '',
//     },
//   );

//   print(_response.headers);
//   final _responseJson = json.decode(_response.body);
//   TraceModel _result = TraceModel.fromJson(_responseJson);
//   print(_responseJson);
//   return _result;
// }

void traceImageFailed(BuildContext context, String message) {
  context.read(btnControllerProvider).state.error();
  final _snackBar = SnackBar(
    content: Text(message),
  );
  // ignore: deprecated_member_use
  Scaffold.of(context).showSnackBar(_snackBar);
  Timer(Duration(seconds: 2), () {
    context.read(btnControllerProvider).state.reset();
  });
}

void traceImageDummy(BuildContext context) {
  Timer(Duration(seconds: 3), () {
    context.read(btnControllerProvider).state.success();
    Timer(Duration(seconds: 1), () {
      context.read(hasResultProvider).state = true;
    });
  });
}

Future<void> getFromGallery(BuildContext context) async {
  PickedFile pickedFile = await ImagePicker().getImage(
    source: ImageSource.gallery,
  );
  if (pickedFile != null) {
    context.read(imageFileProvider).state = File(pickedFile.path);
  }
}

// Future<bool> getPreview(BuildContext context, Docs result) async {
//   final uriEncodeComponent = Uri.encodeComponent(result.filename);

//   var url =
//       "$uriPreviewVideo/${result.anilistId}/$uriEncodeComponent?t=${result.at}&token=${result.tokenthumb}";

//   // print(url);
//   // final _response = await http.get(url);
//   // print(_response.body.runtimeType);
//   context.read(videoControllerProvider).state.dispose();
//   final _controller = VideoPlayerController.network(url);
//   context.read(videoControllerProvider).state = _controller;
//   return true;
// }
