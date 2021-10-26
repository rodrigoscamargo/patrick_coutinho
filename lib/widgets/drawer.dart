import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:patrickcoutinho/blocs/sign_in_bloc.dart';
import 'package:patrickcoutinho/blocs/theme_bloc.dart';
import 'package:patrickcoutinho/config/config.dart';
import 'package:patrickcoutinho/models/custom_color.dart';
import 'package:patrickcoutinho/pages/about_us.dart';
import 'package:patrickcoutinho/pages/acting.dart';
import 'package:patrickcoutinho/pages/bookmarks.dart';
import 'package:patrickcoutinho/utils/app_name.dart';
import 'package:patrickcoutinho/utils/next_screen.dart';
import 'package:patrickcoutinho/widgets/language.dart';
import 'package:patrickcoutinho/widgets/launch_url.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sb = context.watch<SignInBloc>();
    final List titles = [
      'Sobre nós',
      'Áreas de atuação',
      'Contato',
      'Suporte',
    ];
    final List icons = [
      Ionicons.ios_information,
      Ionicons.ios_laptop,
      Ionicons.logo_whatsapp,
      Ionicons.ios_build
    ];

    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              color: context.watch<ThemeBloc>().darkTheme == false
                  ? CustomColor().drawerHeaderColorLight
                  : CustomColor().drawerHeaderColorDark,
              padding: EdgeInsets.all(15),
              //height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //AppName(fontSize: 25.0),
                ],
              ),
            ),
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: titles.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      titles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ).tr(),
                    leading: CircleAvatar(
                        radius: 20,
                        backgroundColor:
                            context.watch<ThemeBloc>().darkTheme == false
                                ? CustomColor().drawerHeaderColorLight
                                : CustomColor().drawerHeaderColorDark,
                        child: Icon(
                          icons[index],
                          color: Colors.grey[600],
                        )),
                    onTap: () async {
                      Navigator.pop(context);
                      if (index == 0) {
                        nextScreen(context, AboutUsPage());
                      } else if (index == 1) {
                        nextScreen(context, ActingPage());
                      } else if (index == 2) {
                        launchURL(context, Config().supportWhatsapp);
                      } else if (index == 3) {
                        await launch('mailto:${Config().supportEmail}?subject=${Config().appName}&body=');
                        // launchURL(context, Config().privacyPolicyUrl);
                      } else if (index == 4) {
                        //await launch('mailto:${Config().supportEmail}?subject=About ${Config().appName} App&body=');
                      }
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
