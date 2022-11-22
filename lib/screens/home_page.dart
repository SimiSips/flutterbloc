import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/bloc/app_blocs.dart';
import 'package:flutterbloc/bloc/app_events.dart';
import 'package:flutterbloc/bloc/app_states.dart';
import 'package:flutterbloc/models/model.dart';

import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _create() async{
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
                      _postData(context);

                      _nameController.text = '';
                      _priceController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Create'),
              ),
            ],
          ),
        );
      }
    );
  }
  void _postData(context){

    BlocProvider.of<ProductBloc>(context).add(Create(_nameController.text, _priceController.text),);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(GetData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: const Center(child: Text('Flutter Bloc Firestore'),),
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),


      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded){
            List<ProductModel> data = state.mydata;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, index){
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(
                                    pro: data[index],
                                  ))
                      );
                    },
                    child: Card(
                      elevation: 8.0,
                      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                      child: Container(
                        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                          title: Text(data[index].name, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          subtitle: Row(
                            children: <Widget>[
                              Text(data[index].price, style: TextStyle(color: Colors.white))
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                        ),
                      ),

                    ),
                  );
                }
            );
          } else if(state is ProductLoading){
            return const Center(

              child: CircularProgressIndicator(
                backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
              ),
            );
          } else {
            return Container();
          }
        }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _create(),
        child: const Icon(Icons.add),
      ),

      floa