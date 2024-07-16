// product_screen.dart
import 'package:c_route_task/bussiness_logih/Bloc.dart';
import 'package:c_route_task/presentation/ProductGrid.dart';
import 'package:c_route_task/presentation/cartScreen.dart';
import 'package:c_route_task/data/repo/ProductsRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Color color1 = Color(0xFF235284);
  Color color2 = Color(0xFF1A237E);
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset('images/logo.png'),
      ),
      body: BlocProvider(
        create: (context) =>
            ProductBloc(ProductRepository())..add(FetchProducts()),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'What do you want to search for?',
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: color1)),
                        prefixIcon: IconButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.search,
                            color: color1,
                          ),
                          onPressed: () {
                            BlocProvider.of<ProductBloc>(context)
                                .add(SearchProducts(_searchController.text));
                          },
                        ),
                      ),
                      onFieldSubmitted: (query) {
                        BlocProvider.of<ProductBloc>(context)
                            .add(SearchProducts(query));
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.shopping_cart_outlined,
                      color: color2,
                    ),
                    onPressed: () {
                      // Handle cart action here
                      Navigator.popAndPushNamed(context, "/cart");
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ProductGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
