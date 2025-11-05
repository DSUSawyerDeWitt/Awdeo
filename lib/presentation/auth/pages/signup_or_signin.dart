import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/appbar/app_bar.dart';
import 'package:songify/common/widgets/button/basic_app_button.dart';
import 'package:songify/core/configs/assets/app_images.dart';
import 'package:songify/core/configs/assets/app_vectors.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/presentation/auth/pages/signin.dart';
import 'package:songify/presentation/auth/pages/signup.dart';

class SignupOrSigninPage extends StatelessWidget {
  const SignupOrSigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          const BasicAppBar(),
          //Align(
          //  alignment: Alignment.topRight,
          //  child: SvgPicture.asset(AppVectors.topPattern),
          //),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo, width: 170,),
                  const SizedBox(height: 55),
                  const Text(
                    'Music, Made Simple',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      //color: AppColors.darkGrey
                    ),
                  ),
                  const SizedBox(height: 21),
                  const Text(
                    'AWDEO is an independent platform for simple, uninterrupted listening.',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      color: AppColors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: BasicAppButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SignupPage()
                              )
                            );
                          },
                          title: 'Register',
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        flex: 1,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) => SigninPage(),
                              )
                            );
                          },
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              //color: Color(0xff313131)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 58),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
