import 'package:flutter/material.dart';
import 'package:shop/models/item.dart';
import 'package:shop/widgets/item_card.dart';

class ItemsList extends StatelessWidget {
  final List<Item> itemsList;
  final Function deleteItemFromList;

  ItemsList({this.itemsList, this.deleteItemFromList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: itemsList.isEmpty
          ?
      Text(
        'No items added',
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
      )
          : ListView.builder(
          itemCount: itemsList.length,
          itemBuilder: (context, index) {
            return ItemCard(item: itemsList[index], deleteItemFromList: deleteItemFromList,);
          }),
    );
  }
}
