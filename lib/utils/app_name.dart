import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/blocs/theme_bloc.dart';
import 'package:provider/provider.dart';
import '../utils/string_extensions.dart';

class AppName extends StatelessWidget {
  final double fontSize;
  const AppName({Key key, @required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeBloc>(
      builder: (_, mode, child) {
        return SizedBox(
          width: 110,
          child: SvgPicture.asset(
            'logo_black_ss'.svg,
            color: mode.darkTheme == true ? Colors.white : Colors.black,
          ),
        );
      },
    );
  }
}
