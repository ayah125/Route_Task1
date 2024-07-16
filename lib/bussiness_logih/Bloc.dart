// product_bloc.dart
import 'package:c_route_task/data/models/Products.dart';
import 'package:c_route_task/data/repo/ProductsRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

class SearchProducts extends ProductEvent {
  final String query;
  SearchProducts(this.query);
}

class AddToCart extends ProductEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends ProductEvent {
  final Product product;
  RemoveFromCart(this.product);
}

// States
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> cart;
  ProductLoaded(this.products, this.cart);
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

// BLoC
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  List<Product> cart = [];

  ProductBloc(this.productRepository) : super(ProductInitial()) {
    on<FetchProducts>(_onFetchProducts);
    on<SearchProducts>(_onSearchProducts);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
  }

  void _onFetchProducts(FetchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.fetchProducts();
      emit(ProductLoaded(products, cart));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onSearchProducts(
      SearchProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await productRepository.searchProducts(event.query);
      emit(ProductLoaded(products, cart));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void _onAddToCart(AddToCart event, Emitter<ProductState> emit) {
    cart.add(event.product);
    emit(ProductLoaded(
        state is ProductLoaded ? (state as ProductLoaded).products : [], cart));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<ProductState> emit) {
    cart.remove(event.product);
    emit(ProductLoaded(
        state is ProductLoaded ? (state as ProductLoaded).products : [], cart));
  }
}
