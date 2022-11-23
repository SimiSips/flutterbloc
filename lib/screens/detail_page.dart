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




  Future<void> _update() async{
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price = double.tryParse(_priceController.text);
                    if (price != null){
                      _updateData(context);

                      _nameController.text = '';
                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Update'),
                ),
              ],
            ),
          );
        }
    );
  }

  void _updateData(context){

    BlocProvider.of<ProductBloc>(context).add(Update(_nameController.text, _priceController.text),);

  }



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
              InkWell(
                onTap: (){
                  _update();
                },
                child: Card(
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
                      trailing: Icon(Icons.edit, color: Colors.white, size: 30.0),
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
