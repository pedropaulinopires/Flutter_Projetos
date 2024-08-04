import 'package:app_float_bar/model/Rive_model.dart';

class NavItemModel {
  final String title;
  final RiveModel rive;

  NavItemModel({
    required this.title,
    required this.rive,
  });

  static List<NavItemModel> bottomNavItems = [
    NavItemModel(
      title: 'Chat',
      rive: RiveModel(
        src: 'assets/animated_icon.riv',
        artboard: 'CHAT',
        stateMachineName: 'CHAT_Interactivity',
      ),
    ),
    NavItemModel(
      title: 'Search',
      rive: RiveModel(
        src: 'assets/animated_icon.riv',
        artboard: 'SEARCH',
        stateMachineName: 'SEARCH_Interactivity',
      ),
    ),
    NavItemModel(
      title: 'Timer',
      rive: RiveModel(
        src: 'assets/animated_icon.riv',
        artboard: 'TIMER',
        stateMachineName: 'TIMER_Interactivity',
      ),
    ),
     NavItemModel(
      title: 'Notification',
      rive: RiveModel(
        src: 'assets/animated_icon.riv',
        artboard: 'BELL',
        stateMachineName: 'BELL_Interactivity',
      ),
    ),
    NavItemModel(
      title: 'Profile',
      rive: RiveModel(
        src: 'assets/animated_icon.riv',
        artboard: 'USER',
        stateMachineName: 'USER_Interactivity',
      ),
    ),
  ];
}
