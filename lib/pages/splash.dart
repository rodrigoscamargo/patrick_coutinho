import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app/pages/welcome.dart';
import 'package:provider/provider.dart';
import '../blocs/sign_in_bloc.dart';
import '../utils/next_screen.dart';
import '../utils/string_extensions.dart';
import 'home.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key key}) : super(key: key);

  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  afterSplash() {
    // final SignInBloc sb = context.read<SignInBloc>();
    // Future.delayed(Duration(milliseconds: 1500)).then((value){
    //   sb.isSignedIn == true || sb.guestUser == true
    //   ? gotoHomePage()
    //   : gotoSignInPage();
    //
    // });

    final SignInBloc sb = context.read<SignInBloc>();
    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      // sb.isSignedIn == true || sb.guestUser == true
      //     ?
      gotoHomePage();
      // : gotoSignInPage();
    });
  }

  gotoHomePage() {
    final SignInBloc sb = context.read<SignInBloc>();
    if (sb.isSignedIn == true) {
      sb.getDataFromSp();
    }
    nextScreenReplace(context, HomePage());
  }

  gotoSignInPage() {
    nextScreenReplace(context, WelcomePage());
  }

  @override
  void initState() {
    afterSplash();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Container(
          child: SvgPicture.asset('logo_black_ss'.svg),
          height: 200,
          width: 120,
          // fit: BoxFit.contain,
        ),
      ),
    );
  }
}
