import 'package:disease_prediction/Services/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PredictionActivity extends StatefulWidget{
  const PredictionActivity({super.key, required this.myList});
  final List<String> myList;

  @override
  State<PredictionActivity> createState() => _PredictionActivityState();
}

class _PredictionActivityState extends State<PredictionActivity> {

  var probabilityList = [];

  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    // print("${widget.myList}");
    getProbability(widget.myList);

  }

  getProbability(var userSymptoms)async{
    var list = await ApiServices().getProbability(userSymptoms);

    if (list != null){
      setState(() {
        isLoaded = true;
        probabilityList = list;
        // print(probabilityList[0]);
        print(list);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predicted Result"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: Column(
            children:[Expanded(
              child: ListView.builder(itemBuilder: (context, index){
                return Card(
                  child: ListTile(
                    title: Text("${probabilityList[index]["name"]}"),
                      trailing: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text("${probabilityList[index]["prob"]}%", style: TextStyle( color: Colors.white), ),
                        ),
                      )
                  ),
                );
              }, itemCount: probabilityList.length,),
            ),
              Container(
                height: 40,
                width: 100,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Back")),
              )
            ]
        ),
      ),

    );
  }
}