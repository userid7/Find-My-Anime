// /// Flutter code sample for ExpansionPanelList.radio

// // Here is a simple example of how to implement ExpansionPanelList.radio.

// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// /// This is the main application widget.
// class MyApp extends StatelessWidget {
//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: MyStatefulWidget(),
//       ),
//     );
//   }
// }

// stores ExpansionPanel state information
import 'package:findmyanime/components/result_list_view.dart';
import 'package:findmyanime/models/tracemodel.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';

class Item {
  Item({
    this.id,
    this.expandedValue,
    this.headerValue,
  });

  int id;
  String expandedValue;
  String headerValue;
}

List<Item> generateItems(int numberOfItems) {
  return List.generate(numberOfItems, (int index) {
    return Item(
      id: index,
      headerValue: 'Panel $index',
      expandedValue: 'This is item number $index',
    );
  });
}

/// This is the stateful widget that the main application instantiates.
class ExpansionRadio extends StatelessWidget {
  ExpansionRadio({Key key, @required this.docs}) : super(key: key);
  final List<Docs> docs;

  List<int> holder = [0, 0];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.8),
        child: ExpansionPanelList.radio(
          expansionCallback: (int index, bool isExpanded) {
            if (index != holder[0]) {
              if (index != holder[1]) {
                context.read(selectedResultProvider).state =
                    SelectedResult(docs: docs[index], index: index);
                holder[0] = holder[1];
                holder[1] = index;
              }
            }
          },
          animationDuration: Duration(seconds: 1),
          initialOpenPanelValue: 1,
          children: docs.map<ExpansionPanelRadio>((Docs item) {
            print(item.isAdult);
            print(item.id);
            if (true) {
              return ExpansionPanelRadio(
                canTapOnHeader: true,
                value: item.id,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Opacity(
                    opacity: item.opacity,
                    child: ListTile(
                      title: Text(
                        item.titleEnglish ?? item.anime ?? "=",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text('EP' + item.episode.toString() ?? "-"),
                          item.season != ""
                              ? Text(' S' + item.season.toString())
                              : Container(),
                        ],
                      ),
                      trailing: Text(
                        item.percentage.toString() ?? "-" + "%", //Text("90%"),
                        style: TextStyle(
                          color: item.percentageColor,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  );
                },
                body: Opacity(
                  opacity: item.opacity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Source"),
                            Text(item.getTimestamp() ?? "--:--:-- - --:--:--"),
                            // Text("00:20:56 - 00:20:57"),
                          ],
                        ),
                        Text(
                          item.filename,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          }).toList(),
        ),
      ),
    );
  }
}
