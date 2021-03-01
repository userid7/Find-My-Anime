import 'package:flutter/material.dart';

class UploadModal extends StatelessWidget {
  const UploadModal({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var uploadGalleryBox = Container(
      width: 400,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 12.0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Upload from Gallery",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Icon(Icons.photo),
            ],
          ),
        ),
      ),
    );

    var uploadURLBox = Container(
      width: 400,
      decoration: BoxDecoration(
          border: Border.all(), borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Upload from URL",
                ),
              ),
            ),
            Icon(Icons.upload_file),
          ],
        ),
      ),
    );

    var contentBox = Container(
      width: 700,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30.0,
          vertical: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            uploadGalleryBox,
            SizedBox(height: 10),
            Text("or"),
            SizedBox(height: 10),
            uploadURLBox
          ],
        ),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox,
    );
  }
}
