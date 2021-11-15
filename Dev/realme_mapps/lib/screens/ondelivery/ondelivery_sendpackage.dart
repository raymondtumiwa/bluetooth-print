import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:realme_mapps/widgets/button_transparentbox.dart';
import 'package:realme_mapps/widgets/textfield.dart';
import '../../constant.dart';

import 'package:realme_mapps/screens/ondelivery/ondelivery_findplace.dart';

class OndeliverySendPackage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kirim Barang'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF15bae8),
                Color(0xFF1254A0),
              ])),
        ),
      ),
      body: CustomScrollView(
        //controller: _hideButtonController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return BodyLayout();
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class BodyLayout extends StatefulWidget {
  @override
  BodyLayoutState createState() {
    return new BodyLayoutState();
  }
}

class BodyLayoutState extends State<BodyLayout> {
  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // backing data
  List<String> _data = ['Sun'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            width: double.infinity,
            child: Card(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(
                "Alamat Pengirim",
                style: kBlackBoldMedium,
                textAlign: TextAlign.left,
              ),
              TextFieldStandard(hintText: "Nama Pengirim"),
              TextFieldStandard(hintText: "No. HP"),
              TextFieldSuffix(
                  icon: Icons.gps_fixed,
                  hintText: "Alamat",
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OndeliveryFind()));
                  }),
              TextFieldStandard(hintText: "Detail Alamat (Opsional)"),
            ]))),
        ButtonTransparentBoxNormal(
          title: "Tambah Alamat",
          onPressed: () => _insertSingleItem(),
        ),
        Container(
          //padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            primary: false,
            shrinkWrap: true,
            // Give the Animated list the global key
            key: _listKey,
            initialItemCount: _data.length,
            // Similar to ListView itemBuilder, but AnimatedList has
            // an additional animation parameter.
            itemBuilder: (context, index, animation) {
              // Breaking the row widget out as a method so that we can
              // share it with the _removeSingleItem() method.
              return _buildItem(_data[index], animation, _data.length);
            },
          ),
        ),
        //if (_data.length != 1)
      ],
    );
  }

  // This is the animated row with the Card.
  Widget _buildItem(String item, Animation animation, int contents) {
    print("hello" + contents.toString());
    print(_data);
    return SizeTransition(
        sizeFactor: animation,
        child: Card(
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Text(
            "Alamat Penerima",
            style: kBlackBoldMedium,
            textAlign: TextAlign.left,
          ),
          TextFieldStandard(hintText: "Nama Penerima"),
          TextFieldStandard(hintText: "No. HP"),
          TextFieldStandard(hintText: "Alamat"),
          TextFieldStandard(hintText: "Detail Alamat (Opsional)"),
          if (contents != 1)
            ButtonTransparentBoxNormal(
              title: "Remove",
              //child: Text('Remove item', style: TextStyle(fontSize: 20)),
              onPressed: () => _removeSingleItem(),
            )
        ])));
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    // Arbitrary location for demonstration purposes
    int insertIndex = 1;
    // Add the item to the data list.
    _data.insert(insertIndex, newItem);
    // Add the item visually to the AnimatedList.
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = 0;
    // Remove item from data list but keep copy to give to the animation.
    String removedItem = _data.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation, _data.length);
    };
    // Remove the item visually from the AnimatedList.
    _listKey.currentState.removeItem(removeIndex, builder);
  }
}
