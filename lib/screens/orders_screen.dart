import 'package:Shop/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    //final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, dataSnapShot) {
          if (dataSnapShot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (dataSnapShot.error == null) {
              return Consumer<Orders>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemBuilder: (ctx, index) => OrderItem(orders.orders[index]),
                  itemCount: orders.orders.length,
                ),
              );
            } else {
              return Center(
                child: Text('An error!'),
              );
            }
          }
        },
      ),
    );
  }
}
