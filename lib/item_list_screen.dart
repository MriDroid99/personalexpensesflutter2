import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Model
import './item.dart';

// Widget
import './bottom_sheet_widget.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({Key? key}) : super(key: key);

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  @override
  List<Item> itemsList = [
    Item('1', 'Title 1', 25, DateTime.now()),
    Item('2', 'Title 3', 250, DateTime.now()),
    Item('3', 'Title 2', 1000, DateTime.now()),
  ];

  void addItem(String id, String title, double price, DateTime date) {
    setState(() {
      itemsList.add(Item(id, title, price, date));
    });
  }

  void removeItem(String id) =>
      itemsList.removeWhere((element) => element.id == id);

  void openSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return BottomSheetWidget(addItem);
        });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Expenses'),
      ),
      body: itemsList.length == 0
          ? Center(
              child: Image.asset('asset/waiting.png'),
            )
          : ListView.builder(
              itemCount: itemsList.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${itemsList[index].price}'),
                      ),
                    ),
                    radius: 25,
                  ),
                  title: Text(itemsList[index].title),
                  subtitle: Text(
                      '${DateFormat.yMMMMd().format(itemsList[index].date)}'),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        removeItem(itemsList[index].id);
                        print(itemsList.length);
                      });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: openSheet,
        child: Icon(Icons.add),
      ),
    );
  }
}
