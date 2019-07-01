import 'package:flutter/material.dart';

class LauncherPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0, 2)).animate(animationController);
    animationController.reverse(from: 2);
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth * .90;
    final double devicePadding = (deviceWidth - targetWidth) / 2;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: devicePadding),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: SlideTransition(
                position: offset,
                child: Text(
                      "daadfasdfadsfwert qwevrdrcwercewfaewsfasdgawesgsdgarlhisgdaruiohgouqparsgofarosgaiohsfgolhfsdgailhsrfgoaishfgioarhgaohsrufghaoerhgarsfgheifdhsgapsfoghiuashrfigoarugharsgfta"
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
