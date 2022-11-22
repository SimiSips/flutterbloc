import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable { ///Use equatable to check if events or states are the same or not
  @override
  List<Object> get props => [];
}

class Create extends ProductEvent{
  final String name;
  final String price;

  Create(this.name, this.price);
} ///This gets called from our bloc
///In Flutter Block, events are represented using classes.
///
class GetData extends ProductEvent{
  GetData();
}

class Update extends ProductEvent{
  final String name;
  final String price;
  final String id;

  Update(this.name, this.price, this.id);
}

