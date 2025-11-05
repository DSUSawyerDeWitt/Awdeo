import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:songify/common/helpers/is_dark_mode.dart';
import 'package:songify/common/widgets/appbar/app_bar.dart';
import 'package:songify/core/configs/assets/app_vectors.dart';
import 'package:songify/core/configs/theme/app_colors.dart';
import 'package:songify/presentation/home/widgets/news_songs.dart';
import 'package:songify/presentation/home/widgets/play_list.dart';
import 'package:songify/presentation/profile/pages/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  late TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        action: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => ProfilePage())
            );
          },
        icon: const Icon(
            Icons.person
          ),
        ),
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        )
      ),
      body: SingleChildScrollView(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _homeTopCard(),
            _tabs(),
            SizedBox(
              height: 210, //Height of the Widgets
              child: TabBarView(
                controller: _tabController,
                children: [
                  const NewsSongs(), //News
                  Container(),       //Future Videos
                  Container(),       //Future Artist
                  Container(),       //Future Podcasts
                ],
              ),
            ),
            const PlayList()
          ],
        )
      )
    );
  }

  Widget _homeTopCard(){
    return Center(
      child: SizedBox(
        height: 140,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: SvgPicture.asset(
                AppVectors.homeTopCard
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabs(){
    return Center(
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelColor: context.isDarkMode ? Colors.white : Colors.black,
        indicatorColor: AppColors.primary,
        dividerColor: Colors.transparent,
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        tabs: [
          Text(
            'News',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )
          ),
          Text(
            'Videos',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )
          ),
          Text(
            'Artists',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )
          ),
          Text(
            'Podcasts',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            )
          ),
        ],
      ),
    );
  }
}