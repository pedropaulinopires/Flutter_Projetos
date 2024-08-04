import 'package:app_float_bar/model/nav_item_model.dart';
import 'package:app_float_bar/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class BottomNavigationBarAnimated extends StatefulWidget {
  const BottomNavigationBarAnimated({
    super.key,
  });

  @override
  State<BottomNavigationBarAnimated> createState() =>
      _BottomNavigationBarAnimatedState();
}

class _BottomNavigationBarAnimatedState
    extends State<BottomNavigationBarAnimated> {
  final _bottomNavItems = NavItemModel.bottomNavItems;

  int _indexSelected = 0;

  void _setIndexSelected(int index) {
    _indexSelected = index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
          color: const Color(0xff17203a),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 5),
                blurRadius: 9,
                spreadRadius: 5)
          ]),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_bottomNavItems.length, (index) {
            var riveModel = _bottomNavItems[index];
            return GestureDetector(
              onTap: () {
                if (index != _indexSelected) {
                  setState(() {
                    _setIndexSelected(index);
                    riveModel.rive.status!.change(true);
                    Future.delayed(const Duration(seconds: 1), () {
                      riveModel.rive.status!.change(false);
                    });
                  });
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 5,
                    width: index == _indexSelected ? 35 : 0,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                  Opacity(
                    opacity: index == _indexSelected ? 1 : 0.5,
                    child: SizedBox(
                      height: 36,
                      width: 36,
                      child: RiveAnimation.asset(
                        riveModel.rive.src,
                        artboard: riveModel.rive.artboard,
                        onInit: (artboard) {
                          var controller = RiveUtils.getRiveController(
                              artboard, riveModel.rive.stateMachineName);
                          riveModel.rive.status =
                              controller.findSMI("active") as SMIBool;
                          riveModel.rive.status!.change(false);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
