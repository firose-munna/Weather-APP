import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'errorScreen.dart';
import 'weatherInfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  TextEditingController cityController = TextEditingController();

  String apiKey = "055bdd7fc3aabea13d9a9d2cdfb71328";
  String city = "Dhaka";
  late Weather weatherInfo;
  bool inProgress = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getWeather();
  }



  void getWeather() async {
    //https://api.openweathermap.org/data/2.5/weather?q=London&appid=055bdd7fc3aabea13d9a9d2cdfb71328
    //call - get
    inProgress = true;

    if(mounted){
      setState(() {});
    }

    Response response = await get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}'));

    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      weatherInfo = Weather.toJson(jsonData);

      inProgress = false;
      if(mounted){
        setState(() {});
      }
    }
    else{
      inProgress = false;
      Navigator.push(context, MaterialPageRoute(builder: (context)=>GetError()));
      if(mounted){
        setState(() {});
      }

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Flutter Weather",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 22),
          ),
          //centerTitle: true,
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
            IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            IconButton(onPressed: () {
              city = "Dhaka";
              cityController.clear();
              getWeather();
              if(mounted){
                setState(() {});
              }
            }, icon: Icon(Icons.home)),
          ],
        ),
        body: inProgress ? const Center(child: CircularProgressIndicator(),):  Center(
            child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.6, 0.95],
            colors: [
              Colors.deepPurple.shade700,
              Colors.deepPurpleAccent.shade100,
            ],
          )),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 40, bottom: 40),
                child: Row(
                  children: [
                    Expanded(
                      flex: 80,
                      child: TextFormField(
                        controller: cityController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: "Type Here The City Name",
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                          prefixIcon: Icon(Icons.search_rounded, color: Colors.white,)
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 20,
                        child: IconButton(
                            onPressed: () {
                              city = cityController.text;
                              getWeather();
                              if(mounted){
                                setState(() {});
                              }
                            },
                            icon: Icon(
                              Icons.arrow_circle_right_rounded,
                              color: Colors.white,
                            )))
                  ],
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      weatherInfo.name,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "Updated: ${weatherInfo.updatedTime}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.network(
                            'http://openweathermap.org/img/w/${weatherInfo.weatherIcon}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${weatherInfo!.temperature.toString()}°",
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Text(
                              "max: ${weatherInfo!.maxTemperature.toString()}°",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                            Text(
                              "min: ${weatherInfo!.minTemperature.toString()}°",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      weatherInfo!.weatherDescription,
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}



