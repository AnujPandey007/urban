import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

class IssuesList extends StatefulWidget {
  final String repoName;
  IssuesList(this.repoName);

  @override
  _IssuesListState createState() => _IssuesListState();
}

class _IssuesListState extends State<IssuesList> {
  bool isLoading = true;
  late List<dynamic> results = [];

  void fetchPost() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/$userName/${widget.repoName}/issues?state=open'));
    if (response.statusCode == 200) {
      results = json.decode(response.body);
      setState(() => isLoading = false);
    } else {
      throw Exception('Failed to load post');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Issues',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index){
              final result = results[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white)
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            result["title"],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(result["user"]["avatar_url"]),
                          backgroundColor: Colors.lightGreenAccent,
                          radius: 14,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        title: Align(
                          alignment: Alignment(-1.2, 0),
                          child: Text(
                            result["user"]["login"],
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
