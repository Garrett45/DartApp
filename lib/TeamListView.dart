import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'Form.dart';
/*
 This file, as a whole, pulls the team numbers from the blue alliance API and creates
 the listview of them.
 */

//This class is how each team number is stored. Storing it as an object
//allows for expandability but is also simpler for me
class Team {
  final int teamNumber;
  final String name;

  Team({this.teamNumber, this.name});

  //a factory method ensures that the same object isn't created twice.
  //fromJson allows us to input Json objects once we isolate them from
  //the JsonArray
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      teamNumber: json['team_number'],
      name: json['nickname']
    );
  }
}

//This method takes grabs the information from the API, and then
//generates all the teams into objects. Afterwards, it returns
//all of these team objects as a list
Future<List<Team>> _fetchTeam() async {
  final response = await http.get(
    'https://www.thebluealliance.com/api/v3/event/2020mnmi2/teams',
    headers: {
      "X-TBA-Auth-Key":
          "qhMCliJtDb8yOV5lmdFJclEigSFaRn5xpnPvQDbfQAT9RGQO8NOZq7EMLK9oKvjX"
    },
  );

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((team) => new Team.fromJson(team)).toList();
  } else {
    // If the server did not return a 200 OK response, then throw an exception.
    throw Exception('Failed to load Team');
  }
}

//This method takes the list of team objects and creates the ListView that
//is displayed
ListView _teamListView(data) {
  return ListView.separated(
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _tile(data[index].teamNumber, data[index].name, context);
      });
}

//This method is used by teamListView and is just all the style options for
//each tile in the list view. It just declutters teamListView and seperates
//out the creation of objects from the styling
//I also put the button functionality here. Its where the boiler plate is
//for every team page
ListTile _tile(int teamNumber, String name, BuildContext context) => ListTile(
      title: Text(teamNumber.toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(name),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(teamNumber.toString()),
                ),
                body: MyCustomForm(),
              );
            },
          ),
        );
      },
    );

//this is the only method used by main. Using a future builder, it waits
//for fetchTeam to get the info from the api, once the data returns
//(which is figured out by snapshot.hasData), it passes that data
//into _teamListView. Otherwise, it spits out an error, or shows a loading
//circle
class TeamListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Team>>(
      future: _fetchTeam(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Team> data = snapshot.data;
          return _teamListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
