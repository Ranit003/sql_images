import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:images_sql/viewimage.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController caption=TextEditingController();
  File? imagepath;
  String? imagename;
  String? imagedata;

  ImagePicker imagePicker=new ImagePicker();
  Future<void> uploadimage() async{
    try{
      String uri = "http://10.0.2.2/uploadimage/uploadimage.php";
      var res=await http.post(Uri.parse(uri),body: {
        "caption":caption.text,
        "data":imagedata,
        "name":imagename,
      });
      var response=jsonDecode(res.body);
      if(response["success"]=="true"){
        print("uploaded");
      }
      else{
        print("some issue");
      }
    }
    catch(e) {
      print(e);
    }
  }
  Future<void> getImage() async{
    var getimage=await imagePicker.pickImage(source:ImageSource.gallery);
    setState(() {
      imagepath=File(getimage!.path);
      imagename=getimage.path.split('/').last;
      imagedata=base64Encode(imagepath!.readAsBytesSync());
      print(imagepath);
      print(imagename);
      print(imagedata);
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Upload Image"),
        ),
        body: Column(
          children: [
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(border: OutlineInputBorder(
              ),
              label: Text("Enter the Caption"),
              ),
            ),
            SizedBox(height: 20,),
            imagepath != null
                ? Image.file(imagepath!)
                : Text("Image not chosen yet"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              getImage();
            }, child: Text("Choose Image")),
            ElevatedButton(onPressed: (){
              setState(() {
                uploadimage();
              });
            }, child: Text("Upload")),
            Builder(builder:(context) {
              return ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder:(context)=>viewimage()));
              }, child:Text("View Data"));
            })
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}