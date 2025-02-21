import 'package:flutter/material.dart';

class ListPulloutData extends StatefulWidget {
  const ListPulloutData({Key? key}) : super(key: key);

  @override
  State<ListPulloutData> createState() => _ListPulloutDataState();
}

class _ListPulloutDataState extends State<ListPulloutData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
