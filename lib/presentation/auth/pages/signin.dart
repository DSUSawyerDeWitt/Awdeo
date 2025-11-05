import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:songify/common/widgets/appbar/app_bar.dart';
import 'package:songify/common/widgets/button/basic_app_button.dart';
import 'package:songify/core/configs/assets/app_vectors.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/data/models/auth/signin_user_req.dart';
import 'package:songify/domain/usecases/auth/signin_usecase.dart';
import 'package:songify/presentation/auth/pages/signup.dart';
import 'package:songify/presentation/home/pages/home.dart';

import '../../../service_locator.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signinText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo, 
          height: 40, 
          width: 40,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 30),
            _emailField(context),
            const SizedBox(height: 20),
            _passwordField(context),
            const SizedBox(height: 20),
            BasicAppButton(
              onPressed: () async {
                var result = await sl<SigninUseCase>().call(
                  params: SigninUserReq(
                    email: _email.text.toString(), 
                    password: _password.text.toString(),
                  ),
                );
                result.fold(
                  (l){
                    var snackbar = SnackBar(content: Text(l, textAlign: TextAlign.center,),);
                    ScaffoldMessenger.of(context).showSnackBar(snackbar);
                  }, 
                  (r){
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => const HomePage()),
                      (route) => false
                    );
                  },
                );
              },
              title: 'Sign In'
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return Text(
      'Sign In',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      controller: _email,
      decoration: const InputDecoration(
        hintText: 'Enter Email',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      controller: _password,
      decoration: InputDecoration(
        hintText: 'Password',
      ).applyDefaults(Theme.of(context).inputDecorationTheme),
    );
  }

  Widget _signinText(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 40
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Not A Member?',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SignupPage())
              );
            },
            child: Text(
              'Register Now',
              style: TextStyle(
                color: AppColors.primary,
              )
            )
          )
        ],
      ),
    );
  }
}