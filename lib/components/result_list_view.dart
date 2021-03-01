import 'package:findmyanime/components/result_list_view_ver2.dart';
import 'package:findmyanime/components/result_list_view_ver3.dart';
import 'package:findmyanime/models/tracemodel.dart';
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

// final _selectedResultProvider = StateProvider<int>((ref) => null);
final selectedResultProvider = StateProvider<SelectedResult>((ref) => null);

class SelectedResult {
  final Docs docs;
  final int index;

  const SelectedResult({this.docs, this.index});
}

final showResultProvider = StateProvider<bool>((ref) => false);

//WORK BUT NOT SMOOTH
class ResultListViewManual extends ConsumerWidget {
  const ResultListViewManual({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // final _showResult = watch(showResultProvider).state;
    final _result = context.read(resultProvider).state;

    return SingleChildScrollView(
      child: AnimatedOpacity(
        opacity: 1,
        duration: const Duration(seconds: 2),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.41,
              ),
              ResultTotalSearchImage(),
              // VerticalExample(),
              // ResultListView(),
              ExpansionRadio(docs: _result.docs),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultTotalSearchImage extends ConsumerWidget {
  const ResultTotalSearchImage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _result = context.read(resultProvider).state;

    return Container(
      height: 20,
      child: Text(
        "Search Result from ${_result.rawDocsCount} images",
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ResultListView extends ConsumerWidget {
  const ResultListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _result = context.read(resultProvider).state;
    final _selectedResult = watch(selectedResultProvider).state;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: _result.docs.length,
          itemBuilder: (BuildContext context, int index) {
            if (!_result.docs[index].isAdult)
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.8),
                    ),
                    child: ExpansionTile(
                      key: GlobalKey(),
                      initiallyExpanded: index == _selectedResult.index,
                      onExpansionChanged: (e) {
                        context.read(selectedResultProvider).state =
                            SelectedResult(
                                docs: _result.docs[index], index: index);
                      },

                      title: Text(
                        _result.docs[index].anime,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ), //Text("One Piece"),
                      subtitle: Row(
                        children: [
                          Text('EP' + _result.docs[index].episode.toString()),
                          _result.docs[index].season != ""
                              ? Text(
                                  ' S' + _result.docs[index].season.toString())
                              : Container(),
                        ],
                      ), //Text("EP2 S4"),
                      trailing: Text(
                        _result.docs[index].percentage.toString() +
                            "%", //Text("90%"),
                        style: TextStyle(
                          color: _result.docs[index].percentageColor,
                          fontSize: 25,
                        ),
                      ),

                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Source"),
                            Text(_result.docs[index].getTimestamp()),
                            // Text("00:20:56 - 00:20:57"),
                          ],
                        ),
                        Text(
                          _result.docs[index].filename,
                          style: TextStyle(fontSize: 12),
                        ),
                        // Text(
                        //   "[Ohys-Raws] Yuru Camp - 05 (AT-X 1280x720 x264 AAC).mp4",
                        //   style: TextStyle(fontSize: 12),
                        // ),
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
              );
          },
        ),
      ),
    );
  }
}
