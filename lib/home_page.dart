import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_app/cubit/app_cubit.dart';
import 'package:tourism_app/misc/colors.dart';
import 'package:tourism_app/widgets/app_large_text.dart';
import 'package:tourism_app/widgets/app_text.dart';
import 'cubit/app_cubit_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  var image = {
  "balloning.png" : "Paragliding",
  "hiking.png" : "Hiking",
  "kayaking.png" : "Rafting",
  "snorkling.png" : "Bungy",
  };

 List info = [];

  _initData(){
  DefaultAssetBundle.of(context).loadString("json/datamodel.json").then((value) {
    json.decode(value);
    setState(() {
      info=json.decode(value);
    });
  });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(
        builder: (context,state){
          if(state is LoadedState){
            var info = state.places;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //menu and profile
                Container(
                  padding: const EdgeInsets.only(top: 70, left: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.black,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5),
                            image: const DecorationImage(
                              image: AssetImage(
                                "assets/img/me.jpeg"
                              ),
                              fit: BoxFit.cover,
                            )
                            ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //discover text
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Discover"),
                ),
                const SizedBox(
                  height: 20,
                ),
                //tab bar
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    labelPadding: const EdgeInsets.only(left: 20, right: 20),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator:
                    CircleTabIndicator(color: AppColors.mainColor, radius: 4),
                    tabs: const [
                      Tab(
                        text: 'Places',
                      ),
                      Tab(
                        text: 'Inspiration',
                      ),
                      Tab(
                        text: 'Emotion',
                      ),
                    ],
                  ),
                ),
                //for places
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  height: 300,
                  width: double.maxFinite,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      ListView.builder(
                        itemCount: info.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: (){
                              BlocProvider.of<AppCubits>(context).detailPage(info[index]);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 15, top: 10),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image:  DecorationImage(
                                      image: NetworkImage(
                                     info[index].img
                                      ),
                                      fit: BoxFit.cover)),
                            ),
                          );
                        },
                      ),
                      const Text("There"),
                      const Text("Bye"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                //explore and see all
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: "Explore more",
                        size: 22,
                      ),
                      AppText(
                        text: "See all",
                        color: AppColors.textColor1,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                //list view for options
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 120,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  child: ListView.builder(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          margin: const EdgeInsets.only(right: 30,),
                          child: Column(
                            children: [
                              Container(
                                //margin: const EdgeInsets.only(right: 30,),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.white,
                                  image:  DecorationImage(
                                      image: AssetImage("assets/img/"+image.keys.elementAt(index)),
                                      fit: BoxFit.cover
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                child: AppText(
                                  text: image.values.elementAt(index),
                                  color: AppColors.textColor2,
                                  size: 15,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                )
              ],
            );
          }else{
            return Container();
          }
        },
      )
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;

  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
