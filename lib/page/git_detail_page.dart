import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/git.dart';
import '../shared/constants.dart';
import 'branch/branch_list.dart';
import 'issues/issues_list.dart';

class GitDetailPage extends StatefulWidget {
  final Git note;
  final int noteId;
  const GitDetailPage({
    Key? key,
    required this.note,
    required this.noteId,
  }) : super(key: key);

  @override
  _GitDetailPageState createState() => _GitDetailPageState();
}

class _GitDetailPageState extends State<GitDetailPage> {
  bool isLoading = true;
  late List<dynamic> result = [];
  int issues = 0;

  void fetchPost() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/${userName}/${widget.note.name}/branches'));
    if (response.statusCode == 200) {
      result = json.decode(response.body);
      setState(() => isLoading = false);
      fetchIssues();
    } else {
      throw Exception('Failed to load post');
    }
  }

  void fetchIssues() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/$userName/${widget.note.name}'));
    if (response.statusCode == 200) {
      setState(() {
        issues = json.decode(response.body)["open_issues_count"];
      });
      print(issues);
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
          'Details',
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          // deleteButton(),
          openWeb()
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(12),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 8),
          children: [
            Text(
              widget.note.name,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 8),
            Text(
              (widget.note.description.isEmpty) ? "Not available" : widget.note.description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    color: Colors.transparent,
                    textColor: Colors.white,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(0)
                    ),
                    child: Text(
                      "BRANCHES",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => BranchList(result, widget.note.name)));
                    },
                  ),
                ),
                Expanded(
                  child: MaterialButton(
                    color: Colors.transparent,
                    textColor: Colors.white,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 1,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(0)
                    ),
                    child: Text(
                      "ISSUES(${issues.toString()})",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => IssuesList(widget.note.name)));
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget openWeb() {
    return IconButton(
      icon: const Icon(Icons.remove_red_eye),
      onPressed: () async {
        String url = 'https://github.com/$userName/${widget.note.name.toString()}';
        await canLaunchUrl(Uri.parse(url)) ? await launchUrl(Uri.parse(url)) : throw 'Could not launch $url';
      }
    );
  }

}
