import 'package:flutter/material.dart';
import 'package:flutterbloc/models/model.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, required this.pro}) : super(key: key);
  final ProductModel pro;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Center(child: Text(pro.name),),
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    title: Text(pro.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Row(
                      children: <Widget>[
                        Text(pro.price, style: TextStyle(color: Colors.white))
                      ],
                    ),
                    trailing: Icon(Icons.edit, color: Colors.white, size: 30.0),
                  ),
                ),

              )
            ],
          ),
        ),
      ),
    );
  }
}
