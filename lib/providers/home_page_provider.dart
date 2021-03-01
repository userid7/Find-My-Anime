import 'dart:io';

import 'package:findmyanime/components/result_list_view.dart';
import 'package:findmyanime/models/tracemodel.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

final resultProvider = StateProvider<TraceModel>((ref) {
  return TraceModel();
});

final hasResultProvider = StateProvider<bool>((ref) {
  final newimg = ref.watch(imageFileProvider);
  return false;
});

final btnControllerProvider = StateProvider<RoundedLoadingButtonController>(
    (ref) => new RoundedLoadingButtonController());

final isSuccessProvider = StateProvider<bool>((ref) {
  final newimg = ref.watch(imageFileProvider);
  return false;
});

final imageFileProvider = StateProvider<File>((ref) {
  return null;
});

final linkProvider = StateProvider<String>((ref) {
  final _result =
      ref.watch(selectedResultProvider).state.docs.anilistId.toString();
  return _result;
});

// final videoControllerProvider = StateProvider<VideoPlayerController>(
//     (ref) => VideoPlayerController.network(""));

// void getPreview(BuildContext context, Docs result) {
//   final _uriPreviewVideo = "https://media.trace.moe/video";
//   final _uriPreviewImage = "https://media.trace.moe/Image";

//   final uriEncodeComponent = Uri.encodeComponent(result.filename);

//   var url =
//       "$_uriPreviewVideo/${result.anilistId}/$uriEncodeComponent?t=${result.at}&token=${result.tokenthumb}";

//   context.read(urlProvider).state = url;
// }
