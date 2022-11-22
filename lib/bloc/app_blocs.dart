import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterbloc/bloc/app_events.dart';
import 'package:flutterbloc/bloc/app_states.dart';
import 'package:flutterbloc/repos/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(InitialState()) {
    on<Create>((event, emit) async {
      emit(ProductAdding());
      await Future.delayed(const Duration(seconds: 1));
      try {
        await productRepository.create(
            name: event.name,
            price: event.price);
        emit(ProductAdded());
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });

    on<GetData>((event, emit) async {
      emit(ProductLoading());
      await Future.delayed(const Duration(seconds: 1));
      try {
        final data = await productRepository.get();
        emit(ProductLoaded(data));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}