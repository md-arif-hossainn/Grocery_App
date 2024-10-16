import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:grocery_app/screens/viewed_recently/viewed_recently.dart';
import 'package:grocery_app/screens/wishlist/wishlist_screen.dart';
import 'package:grocery_app/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';
import '../services/global_methods.dart';
import 'orders/orders_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController =
  TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Hi, ',
                        style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Arif',
                              style: TextStyle(
                                color: color,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  print('My name is pressed');
                                }),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextWidget(
                      text: 'arif134221@gmail.com',
                      color: color,
                      textSize: 18,
                      // isTitle: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _listTiles(
                      title: 'Address',
                      subtitle: 'Dhaka, Bangladesh',
                      icon: IconlyLight.profile,
                      onPressed: () {
                        GlobalMethods.warningDialog(
                            title: 'Sign out',
                            subtitle: 'Do you wanna sign out?',
                            fct: () {},
                            context: context);

                      },
                      color: color,
                    ),
                    _listTiles(
                      title: 'Orders',
                      icon: IconlyLight.bag,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: OrdersScreen.routeName);
                      },
                      color: color,
                    ),
                    _listTiles(
                      title: 'Wishlist',
                      icon: IconlyLight.heart,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: WishlistScreen.routeName);
                      },
                      color: color,
                    ),
                    _listTiles(
                      title: 'Viewed',
                      icon: IconlyLight.show,
                      onPressed: () {
                        GlobalMethods.navigateTo(
                            ctx: context, routeName: ViewedRecentlyScreen.routeName);
                      },
                      color: color,
                    ),
                    _listTiles(
                      title: 'Forget password',
                      icon: IconlyLight.unlock,
                      onPressed: () {},
                      color: color,
                    ),
                    SwitchListTile(
                      title: TextWidget(
                        text: themeState.getDarkTheme ? 'Dark mode' : 'Light mode',
                        color: color,
                        textSize: 18,
                        // isTitle: true,
                      ),
                      secondary: Icon(themeState.getDarkTheme
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined),
                      onChanged: (bool value) {
                        setState(() {
                          themeState.setDarkTheme = value;
                        });
                      },
                      value: themeState.getDarkTheme,
                    ),
                    _listTiles(
                      title: 'Logout',
                      icon: IconlyLight.logout,
                      onPressed: () {
                        _showLogoutDialog();
                      },
                      color: color,
                    ),
                   // listTileAsRow(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return ListTile(
      title: TextWidget(
        text: title,
        color: color,
        textSize: 22,
        //isTitle: true,
      ),
      subtitle: subtitle!=null ? TextWidget(
        text: subtitle ?? "",
        color: color,
        textSize: 18,
      ):null,
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: () {
        onPressed();
      },
    );
  }

// Alternative code for the listTile.
//   Widget listTileAsRow() {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         children: <Widget>[
//           const Icon(Icons.settings),
//           const SizedBox(width: 10),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: const [
//               Text('Title'),
//               Text('Subtitle'),
//             ],
//           ),
//           const Spacer(),
//           const Icon(Icons.chevron_right)
//         ],
//       ),
//     );
//   }


  Future<void> _showLogoutDialog() async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset(
                'assets/images/warning-sign.png',
                height: 20,
                width: 20,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                width: 8,
              ),
              const Text('Sign out'),
            ]),
            content: const Text('Do you wanna sign out?'),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: TextWidget(
                  color: Colors.red,
                  text: 'OK',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }

}
