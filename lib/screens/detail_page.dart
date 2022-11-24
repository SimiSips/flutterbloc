import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/models/model.dart';

import '../bloc/app_blocs.dart';
import '../bloc/app_events.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.pro}) : super(key: key);
  final ProductModel pro;


  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Center(child: Text(widget.pro.name),),
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
                    title: Text(widget.pro.name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                    subtitle: Row(
                      children: <Widget>[
                        Text(widget.pro.price, style: TextStyle(color: Colors.white))
                      ],
                    ),

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
