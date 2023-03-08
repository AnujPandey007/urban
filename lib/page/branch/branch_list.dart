import 'package:flutter/material.dart';
import 'commit_list.dart';

class BranchList extends StatefulWidget {
  final List<dynamic> result;
  final String repoName;
  BranchList(this.result, this.repoName);

  @override
  _BranchListState createState() => _BranchListState();
}

class _BranchListState extends State<BranchList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.repoName,
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: widget.result.length,
          itemBuilder: (context, index){
            final result = widget.result[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommitList(widget.repoName, result["name"], result["commit"]["sha"])));
                },
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Text(
                    result["name"],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
