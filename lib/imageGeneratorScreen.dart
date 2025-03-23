import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text("AI image generator", style: TextStyle(color: Colors.white),),centerTitle: true,
      ),
      body: Column(children: [
        Icon(Icons.ac_unit,size: 250,),
        Row(
          children: [
            Expanded(child: TextField()),
            InkWell(child: Icon(Icons.send), onTap: (){
              
            },)
          ],
        )
      ],),
    );
  }
}