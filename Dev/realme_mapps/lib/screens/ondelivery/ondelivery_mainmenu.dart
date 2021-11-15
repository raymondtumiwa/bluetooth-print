import 'package:flutter/material.dart';
import 'package:realme_mapps/widgets/button_transparentbox.dart';
import 'package:realme_mapps/screens/ondelivery/ondelivery_sendpackage.dart';
import 'package:realme_mapps/screens/ondelivery/ondelivery_trackpackage.dart';

class OndeliveryMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKey,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/onapps_text.png',
          fit: BoxFit.contain,
          height: 100,
        ),
        //centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.mail),
            tooltip: 'Show Messages',
            onPressed: () {
              //scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
        ],
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

      body: Center(
        child: Column(
          //controller: _hideButtonController,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                //width: double.infinity * 0.8,
                width: MediaQuery.of(context).size.width * 0.9,
                height: 300,
                child: Column(
                  children: <Widget>[
                    ButtonTransparentBox(
                      title: 'Kirim Paket',
                      onTap: OndeliverySendPackage(),
                    ),
                    ButtonTransparentBox(
                      title: 'Lacak Paket',
                      onTap: OndeliveryTrackPackage(),
                    ),
                    ButtonTransparentBox(title: 'Cek Biaya'),
                    ButtonTransparentBox(title: 'Riwayat Pengiriman'),
                  ],
                ))

            /*
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return _widgetOptions.elementAt(_selectedIndex);
              },
              childCount: 1,
            ),
          ),*/
          ],
        ),
      ),
    );
  }
}
