import 'package:flutter/material.dart';

class GitFormWidget extends StatelessWidget {
  final String? title;
  final ValueChanged<String> onChangedTitle;

  const GitFormWidget({
    Key? key,
    this.title = '',
    required this.onChangedTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          // mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Owner / Organization",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (val)=> val!.isEmpty ? "The Owner Name cannot be empty" : null,
            ),
            SizedBox(height: 18),
            Text(
              "Repo Name",
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              maxLines: 1,
              initialValue: title,
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              validator: (title) => title != null && title.isEmpty ? 'The title cannot be empty' : null,
              onChanged: onChangedTitle,
            ),
          ],
        ),
      ),
    );
  }
}
