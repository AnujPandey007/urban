import 'package:flutter/material.dart';
import 'package:share/share.dart';
import '../model/git.dart';
import '../shared/constants.dart';

class GitCardWidget extends StatelessWidget {
  GitCardWidget({
    Key? key,
    required this.note,
    required this.index,
  }) : super(key: key);

  final Git note;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    (note.description.isEmpty) ? "Not available" : note.description,
                    style: TextStyle(
                        color: Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            MaterialButton(
              color: Colors.white,
              elevation: 0.0,
              minWidth: 20,
              child: const Icon(Icons.send, color: Colors.black,),
              onPressed: () async {
                final link = "Name: ${note.name}\nDescription: ${note.description}\nUrl: 'https://github.com/${userName}/${note.name.toString()}";
                Share.share(link);
              },
            ),
          ],
        ),
      ),
    );
  }
}
