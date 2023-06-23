import 'package:disease_prediction/prediction_activity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Services/ApiService.dart';

class SymptomsSelectionActivity extends StatefulWidget{
  const SymptomsSelectionActivity({super.key});

  @override
  State<SymptomsSelectionActivity> createState()=> _SymptomsSelectionActivityState();

}

class _SymptomsSelectionActivityState extends State<SymptomsSelectionActivity> {

  var symptomsList = [];

  List<String> tempList = [];

  var isLoaded = false;

  @override
  void initState(){
    super.initState();
    getSymptoms();

  }

  getSymptoms()async{
    var list = await ApiServices().getSymptoms();
    if (list != null){
      setState(() {
        isLoaded = true;
        symptomsList = list;
        print(symptomsList[0]);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Disease Prediction App"),
      ),
      body: Visibility(
        visible: isLoaded,
        child: Column(
            children:[Expanded(
              child: ListView.builder(itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    setState(() {
                      if(tempList.length <5 && !tempList.contains(symptomsList[index])){
                        tempList.add(symptomsList[index]);

                        }else if(tempList.contains(symptomsList[index])){
                            tempList.remove(symptomsList[index]);
                        }
                    });

                  },
                  child: Card(
                    child: ListTile(
                      title: Text(symptomsList[index]),
                      trailing: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: tempList.contains(symptomsList[index])? Colors.red : Colors.green,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(tempList.contains(symptomsList[index])? "Remove" : "Add", style: TextStyle( color: Colors.white), ),
                        ),
                      ),
                    ),
                  ),
                );
              }, itemCount: symptomsList.length,),
            ),
              Visibility(
                visible: tempList.isNotEmpty,
                child: Container(
                  height: 65,
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,

                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          setState(() {
                            tempList.remove(tempList[index]);
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Center(
                              child: Text(tempList[index], style: TextStyle( color: Colors.white),),
                            ),
                          ),
                        ),
                      );
                    }, itemCount: tempList.length,),
                ),
              ),
              Container(
                height: 40,
                margin: EdgeInsets.all(10),
                child: ElevatedButton(onPressed: (){

                  print(tempList);
                  if (!tempList.isEmpty){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PredictionActivity(myList : tempList)));
                  }

                }, child: Text("Predict")),
              )
            ]
        ),
      ),

    );
  }
}