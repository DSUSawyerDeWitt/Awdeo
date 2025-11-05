import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:songify/common/widgets/button/basic_app_button.dart';
import 'package:songify/core/configs/assets/app_images.dart';
import 'package:songify/core/configs/assets/app_vectors.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/presentation/choose_mode/pages/choose_mode.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(AppImages.introBG),
              ),
            ),
          ),
          Container(
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(.15),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 40,
              horizontal: 40
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: SvgPicture.asset(
                    AppVectors.logo,
                    width: 200
                    ),
                ),
                Spacer(),
                Text(
                  'Pure Sound. No Static. AWDEO',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'AWDEO is a free noncommercial audio streamer designed to let users listen to music without ads or subscriptions. '
                  'Made for people who just want to press play and listen.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                    fontSize: 13,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                BasicAppButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ChooseModePage()
                      )
                    );
                  },
                  title: 'Get Started',
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
