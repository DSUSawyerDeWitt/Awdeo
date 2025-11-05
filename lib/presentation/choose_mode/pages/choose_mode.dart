import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/button/basic_app_button.dart';
import 'package:songify/core/configs/assets/app_images.dart';
import 'package:songify/core/configs/assets/app_vectors.dart';
import 'package:songify/presentation/auth/pages/signup_or_signin.dart';
import 'package:songify/presentation/choose_mode/bloc/theme_cubit.dart';

class ChooseModePage extends StatelessWidget {
  const ChooseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentThemeMode = context.watch<ThemeCubit>().state; //Watch for Theme Change
    final isDark;
    if (currentThemeMode == ThemeMode.dark){
      isDark = true;
    } else {
      isDark = false;
    }

    final mainImageAsset = isDark //Change Image
        ? AppImages.darkModeMoon
        : AppImages.lightModeSun;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(mainImageAsset),
                ),
                const SizedBox(height: 40),
                Text(
                  'Choose Mode',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.isDarkMode ? Colors.white : Colors.black, 
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 21),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ModeButton(
                      label: 'Dark Mode',
                      vectorAsset: AppVectors.moon,
                      mode: ThemeMode.dark,
                      currentMode: currentThemeMode,
                    ),
                    const SizedBox(width: 40),
                    _ModeButton(
                      label: 'Light Mode',
                      vectorAsset: AppVectors.sun,
                      mode: ThemeMode.light,
                      currentMode: currentThemeMode,
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const SignupOrSigninPage(),
                      ), 
                    );
                  },
                  title: 'Continue',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeButton extends StatelessWidget {
  final String label; //Text
  final String vectorAsset; //Image
  final ThemeMode mode; //New Theme
  final ThemeMode currentMode; //Current Theme

  const _ModeButton({
    required this.label,
    required this.vectorAsset,
    required this.mode,
    required this.currentMode,
  });

  @override
  Widget build(BuildContext context) {
    // Determine if this button represents the currently active mode
    final bool isSelected;
    if(mode == currentMode){
      isSelected = true;
    } else{
      isSelected = false;
    }

    final bool isDarkMode;
    if(currentMode == ThemeMode.dark){
      isDarkMode = true;
    } else{
      isDarkMode = false;
    }
    
    final buttonColor = isSelected 
        ? Colors.black.withOpacity(0.1) // ignore: deprecated_member_use
        : const Color(0xff30393C).withOpacity(0.5); // ignore: deprecated_member_use

    final iconBorderColor = isDarkMode ? Colors.white : Colors.black;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            context.read<ThemeCubit>().updateTheme(mode);
          },
          child: ClipOval(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: buttonColor,
                  shape: BoxShape.circle,
                  border: isSelected //Thicker Border
                      ? Border.all(color: iconBorderColor, width: 2) 
                      : null,
                ),
                child: SvgPicture.asset(
                  vectorAsset,
                  fit: BoxFit.none,
                  colorFilter: ColorFilter.mode(iconBorderColor, BlendMode.srcIn) //Change Icon Colors
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 13,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}