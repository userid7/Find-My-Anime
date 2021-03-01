// import 'package:findmyanime/providers/homepageProvider.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// // import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// // class ResultListView extends StatelessWidget {
// //   const ResultListView({Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return AnimationLimiter(
// //       child: ListView.builder(
// //         itemCount: 100,
// //         itemBuilder: (BuildContext context, int index) {

// //           return AnimationConfiguration.staggeredList(
// //             position: index,
// //             duration: const Duration(milliseconds: 375),
// //             child: SlideAnimation(
// //               verticalOffset: 50.0,
// //               child: FadeInAnimation(
// //                 child: ExpansionTile(
// //                   title: ListTile(),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }

// final _selectedResultProvider = StateProvider<int>((ref) => null);

// //WORK BUT NOT SMOOTH
// class ResultListViewManual extends ConsumerWidget {
//   const ResultListViewManual({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, ScopedReader watch) {
//     final _result = watch(resultProvider).state;
//     final _selectedResult = watch(_selectedResultProvider).state;

//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         horizontal: 8.0,
//       ),
//       child: ListView.builder(
//         itemCount: 5,
//         itemBuilder: (BuildContext context, int index) {

//           return AnimatedOpacity(
//             opacity: 1.0,
//             duration: const Duration(milliseconds: 1000),
//             child: Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(5.8),
//                   ),
//                   child: ExpansionTile(
//                     key: GlobalKey(),
//                     initiallyExpanded: index == _selectedResult,
//                     onExpansionChanged: (e) {
//                       context.read(_selectedResultProvider).state = index;
//                       print(_selectedResult);
//                     },
//                     title: ListTile(
//                       title:
//                           Text(_result.docs[index].anime), //Text("One Piece"),
//                       subtitle: Text('EP' +
//                           _result.docs[index].episode.toString() +
//                           ' S' +
//                           _result.docs[index].episode
//                               .toString()), //Text("EP2 S4"),
//                       trailing: Text(
//                         (_result.docs[index].similarity * 100).toString() +
//                             "%", //Text("90%"),
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontSize: 25,
//                         ),
//                       ),
//                     ),
//                     children: <Widget>[
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Source"),
//                           Text(_result.docs[index].getTimestamp()),
//                           // Text("00:20:56 - 00:20:57"),
//                         ],
//                       ),
//                       Text(
//                         _result.docs[index].filename,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       // Text(
//                       //   "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
//                       //   style: TextStyle(fontSize: 12),
//                       // ),
//                     ],
//                     childrenPadding: EdgeInsets.symmetric(
//                       horizontal: 18,
//                       vertical: 8,
//                     ),
//                     expandedCrossAxisAlignment: CrossAxisAlignment.start,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

////////////////////////////////////////////////      OLD

import 'package:findmyanime/providers/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

// class ResultListView extends StatelessWidget {
//   const ResultListView({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return AnimationLimiter(
//       child: ListView.builder(
//         itemCount: 100,
//         itemBuilder: (BuildContext context, int index) {

//           return AnimationConfiguration.staggeredList(
//             position: index,
//             duration: const Duration(milliseconds: 375),
//             child: SlideAnimation(
//               verticalOffset: 50.0,
//               child: FadeInAnimation(
//                 child: ExpansionTile(
//                   title: ListTile(),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

final _selectedResultProvider = StateProvider<int>((ref) => null);

//WORK BUT NOT SMOOTH
class ResultListViewManual extends ConsumerWidget {
  const ResultListViewManual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _result = watch(resultProvider).state;
    final _selectedResult = watch(_selectedResultProvider).state;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 1000),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.8),
                  ),
                  child: ExpansionTile(
                    key: GlobalKey(),
                    initiallyExpanded: index == _selectedResult,
                    onExpansionChanged: (e) {
                      context.read(_selectedResultProvider).state = index;
                      print(_selectedResult);
                    },
                    title: ListTile(
                      title: Text("One Piece"),
                      subtitle: Text("EP2 S4"),
                      trailing: Text(
                        "90%",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Source"),
                          Text("00:20:56 - 00:20:57"),
                        ],
                      ),
                      Text(
                        "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                    childrenPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    expandedCrossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
