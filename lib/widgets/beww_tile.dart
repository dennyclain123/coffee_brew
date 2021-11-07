import 'package:coffee_brew/models/brew.dart';
import 'package:flutter/material.dart';
class BrewTile extends StatefulWidget {
  final Brew brew;
  BrewTile({this.brew});

  @override
  _BrewTileState createState() => _BrewTileState();
}

class _BrewTileState extends State<BrewTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[widget.brew.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png')
          ),
          title: Text(widget.brew.name),
          subtitle: Text("Takes ${widget.brew.sugars} sugar(s)"),
        ),
      ),
    );
  }
}
