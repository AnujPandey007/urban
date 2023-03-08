import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

class CommitList extends StatefulWidget {
  final String repoName;
  final String sha;
  final String branchName;
  CommitList(this.repoName, this.branchName, this.sha);

  @override
  _CommitListState createState() => _CommitListState();
}

class _CommitListState extends State<CommitList> {

  bool isLoading = true;
  late List<dynamic> results = [];

  void fetchPost() async {
    final response = await http.get(Uri.parse('https://api.github.com/repos/${userName}/${widget.repoName}/commits?sha=${widget.sha}'));
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

  String getMonth(int month){
    if(month==1){
      return "Jan";
    }else if(month==2){
      return "Feb";
    }else if(month==3){
      return "Mar";
    }else if(month==4){
      return "Apr";
    }else if(month==5){
      return "May";
    }else if(month==6){
      return "Jun";
    }else if(month==7){
      return "Jul";
    }else if(month==8){
      return "Aug";
    }else if(month==9){
      return "Sep";
    }else if(month==10){
      return "Oct";
    }else if(month==11){
      return "Nov";
    }else if(month==12){
      return "Dec";
    }
    return "Error";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Commits",
              style: TextStyle(fontSize: 14),
            ),
            Text(
              widget.branchName,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      body: isLoading ? Center(
        child: Container(
          child: CircularProgressIndicator(),
        ),
      ) : Container(
          child: ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index){
              final result = results[index];
              // print(result);
              if(result==null){
                return Text("Null");
              }else{
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white)
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ("${DateTime.parse(result["commit"]["committer"]["date"].toString()).day} ${getMonth(DateTime.parse(result["commit"]["committer"]["date"].toString()).month)} ${DateTime.parse(result["commit"]["committer"]["date"].toString()).year.toString().substring(2, 4)}").toString(),
                                style: TextStyle(fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                result["sha"],
                                style: TextStyle(fontSize: 10, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              result["commit"]["message"],
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: (result["committer"]==null || result["committer"].toString() == "null" || result["committer"].toString()=="") ? NetworkImage("https://w7.pngwing.com/pngs/340/956/png-transparent-profile-user-icon-computer-icons-user-profile-head-ico-miscellaneous-black-desktop-wallpaper.png") : NetworkImage(result["committer"]["avatar_url"]),
                            backgroundColor: Colors.lightGreenAccent,
                            radius: 14,
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          title: Align(
                            alignment: Alignment(-1.2, 0),
                            child: Text(
                              result["commit"]["committer"]["name"],
                              style: TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          )
      ),
    );
  }
}
