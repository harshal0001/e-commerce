import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/screens/edit_product_screen.dart';

class UserProductItems extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductItems(
      {Key? key, required this.title, required this.imageUrl, required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamed(EditProductsScreen.routeName, arguments: id);
            },
            icon: Icon(Icons.edit),
            color: Theme.of(context).primaryColor,
          ),
          IconButton(
            onPressed: () {
              Provider.of<ProductsProvider>(context, listen: false)
                  .deleteProduct(id);
            },
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
          ),
        ]),
      ),
    );
  }
}
