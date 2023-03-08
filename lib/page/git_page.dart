import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/git.dart';
import '../shared/constants.dart';
import '../widget/git_card_widget.dart';
import 'git_detail_page.dart';


class GitPage extends StatefulWidget {
  @override
  _GitPageState createState() => _GitPageState();
}

class _GitPageState extends State<GitPage> {
  late List<dynamic> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshGit();
  }

  Future refreshGit() async {
    setState(() => isLoading = true);
    this.notes = [];
    fetchPost();
  }

  void fetchPost() async {
    List<dynamic> temp=[];
    final response = await http.get(Uri.parse('https://api.github.com/users/$userName/repos'));
    temp.addAll(notes);
    if (response.statusCode == 200) {
      List<dynamic> values= new List<dynamic>.empty();
      values = json.decode(response.body);
      if(values.length>0){
        for(int i=0;i<values.length;i++){
          if(values[i]!=null){
            Map<String,dynamic> map = values[i];
            temp.add(Git.fromJsonApi(map));
          }
        }
      }
      setState(() {
        notes = temp;
      });
      setState(() => isLoading = false);
    } else {
      print(response.body);
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Github Browser',
          style: TextStyle(fontSize: 17),
        ),
      ),
      body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
              ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Track your favourite repo',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ],
          ) : reposList()
      ),
    );
  }

  Widget reposList(){
    return ListView.builder(
      itemCount: notes.length,
        itemBuilder: (context, index){
          final note = notes[index];
          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GitDetailPage(noteId: note.id!, note: note),
              ));
              // refreshGit();
            },
            child: GitCardWidget(note: note, index: index),
          );
        },
    );
  }
}
