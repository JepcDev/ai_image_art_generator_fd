import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  TextEditingController controller = TextEditingController();

  generateImage(var prompt) async {

    var request = http.MultipartRequest('POST', Uri.parse("https://api.vyro.ai/v2/image/generations"));
    request.headers['Authorization'] = "Bearer vk-B9fE8RCDK6VhTF25liTuFNcwHarn2il0otgj3NLCuRDL3M7";
    request.fields["prompt"] = prompt;
    request.fields["style"] = "realistic";
    request.fields["aspect_ratio"] = "1:1";
    request.fields["seed"]= "0";

    var response = await request.send();

    if (response.statusCode ==200) {
      print("image generated successfully");
    }else{
      print(response.statusCode);
    }
  }

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
            Expanded(child: TextField(controller: controller,)),
            InkWell(child: Icon(Icons.send), onTap: (){
              generateImage(controller.text);
            },)
          ],
        )
      ],),
    );
  }
}