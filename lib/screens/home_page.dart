import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: const Center(child: Text('Home'),),
        elevation: 0.1,
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
        child: ListView(

          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
              accountName: Text(
                "Simphiwe Radebe",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              accountEmail: Text(
                "simphiwe.radebe0706@gmail.com",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              currentAccountPicture: FlutterLogo(),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
              ),
              title: const Text('Crashlytics', style: TextStyle(color: Colors.white),),
              onTap: () => throw Exception(),
            ),

          ],
        ),
      ),


      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoaded){
            List<ProductModel> data = state.mydata;
            List<ProductModel> displayList = List.from(data);

            void updateList(String value){
              displayList = data.where((product) => product.name.toLowerCase().contains(value.toLowerCase())).toList();
              if (kDebugMode) {
                for(var i = 0; i < displayList.length; i++){
                  print(displayList[i].name);
                }
               /* print(data.where((product) => product.name.toLowerCase().contains(value.toLowerCase())).toList());*/
              }
            }

            return Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                      onChanged: (value) => updateList(value),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(64, 75, 96, .9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: "Search",
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: Colors.white,
                      ),
                    ),
                ),
                const SizedBox(height: 20.0),
                Expanded(child:  ListView.builder(
                   itemCount: displayList.length,
                   itemBuilder: (_, index){
                     return InkWell(
                       onTap: () {
                         Navigator.of(context).push(
                             MaterialPageRoute(
                                 builder: (context) =>
                                     DetailScreen(
                                       pro: displayList[index],

                                     ))
                         );
                       },
                       child: Card(
                         elevation: 8.0,
                         margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                         child: Container(
                           decoration: const BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                           child: ListTile(
                             contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                             title: Text(displayList[index].name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                             subtitle: Row(
                               children: <Widget>[
                                 Text(displayList[index].price, style: const TextStyle(color: Colors.white))
                               ],
                             ),
                             trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                           ),
                         ),

                       ),
                     );
                   }
               ),)
              ],
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

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
