import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageGeneratorScreen extends StatefulWidget {
  const ImageGeneratorScreen({super.key});

  @override
  State<ImageGeneratorScreen> createState() => _ImageGeneratorScreenState();
}

class _ImageGeneratorScreenState extends State<ImageGeneratorScreen> {
  TextEditingController controller = TextEditingController();

  var genImg;
  bool loading = false;

// NOTE -> generateImage
  generateImage(var prompt) async {
    setState(() {
      loading = true;
    });
    controller.text = "";
    var request = http.MultipartRequest(
        'POST', Uri.parse("https://api.vyro.ai/v2/image/generations"));
    request.headers['Authorization'] =
        "Bearer vk-B9fE8RCDK6VhTF25liTuFNcwHarn2il0otgj3NLCuRDL3M7";
    request.fields["prompt"] = prompt;
    request.fields["style"] = "realistic";
    request.fields["aspect_ratio"] = "1:1";
    request.fields["seed"] = "0";

    var response = await request.send();

    if (response.statusCode == 200) {
      print("image generated successfully");
      var completeResponse = await http.Response.fromStream(
          response); //obtenemos el objeto con la respuesta completa de la peticion

      Directory directory =
          await getApplicationDocumentsDirectory(); // Proporsiona una direccion de los archivos del usuario
      genImg = File("${directory.path}/genimg.jpg");
      await genImg.writeAsBytes(completeResponse.bodyBytes);

      setState(() {
        genImg;
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen[300],
        title: Text(
          "AI image generator",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8)),
                  child: loading
                      ? SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.teal,
                          )))
                      : genImg != null
                          ? Image.file(genImg)
                          : Icon(
                              Icons.ac_unit,
                              size: 250,
                            ),
                ),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: "Type here..."),
                    )),
                    InkWell(
                      child: Icon(Icons.send),
                      onTap: () {
                        generateImage(controller.text);
                      },
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
