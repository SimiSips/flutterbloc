import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterbloc/bloc/app_blocs.dart';
import 'package:flutterbloc/bloc/app_states.dart';
import 'package:flutterbloc/repos/product_repository.dart';
import 'package:flutterbloc/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //FirebaseCrashlytics.instance.crash();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
          create: (context) => ProductRepository(),
          child: const Home(),
        )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    
    return BlocProvider(
        create: (context) => ProductBloc(
            productRepository: RepositoryProvider.of<ProductRepository>(context)
        ),
      child: Scaffold(
        key: scaffoldKey,
        body: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
              if (state is ProductAdded) {

                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Added"), duration: Duration(seconds: 3)));
              }
            },
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductAdding) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if(state is ProductError){
                return const Center(child: Text("Error"),);
              }
              return const HomePage();
            },
          ),
        ),
      ),
    );
  }
}

