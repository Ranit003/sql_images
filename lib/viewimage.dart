import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;

class viewimage extends StatefulWidget {
  const viewimage({super.key});

  @override
  State<viewimage> createState() => _viewimageState();
}

class _viewimageState extends State<viewimage> {
  List record =[];
  Future<void> imagefromdb()async{
    try{
      String uri = "http://10.0.2.2/uploadimage/viewimage.php";
      var response = await http.get(Uri.parse(uri));
      setState(() {
        record=jsonDecode(response.body);
      });

    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    imagefromdb();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("view image from my sql"),
      ),
      body: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
          itemBuilder:(BuildContext context, int index){
           return Card(
             margin: EdgeInsets.all(10),
             child: Column(
               children: [
                 Container(child:Expanded(child:Image.network("http://10.0.2.2/uploadimage/"+record[index]["image_path"]))),
                 Container(child: Text(record[index]["caption"]),)
               ],
             ),
           );
          }),
    );
  }
}
