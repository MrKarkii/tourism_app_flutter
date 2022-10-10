import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourism_app/widgets/app_large_text.dart';
import 'package:tourism_app/widgets/app_text.dart';
import 'package:tourism_app/widgets/responsive_button.dart';

import '../cubit/app_cubit.dart';
import '../misc/colors.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images = [
    "welcome-one.png",
    "welcome-two.png",
    "welcome-three.png"
  ];

  List text = [
    "Hills",
    "Mountain",
    "Lake"
  ];

  List textDescription = [
    "Plain hills of this country will give u all the scenery and pleasures of beauty with all the habitats of living beings around.",
    "Mountain hikes give you an incredible sense of feeling along with endurance tests.",
    "Lake, a place where you forget the worries and swim with the mighty nature of the water wave flowing."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_ , index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/img/"+images[index],
                  ),
                  fit: BoxFit.cover
                ),
              ),
              child: Container(
                 margin: const EdgeInsets.only(
                   top: 150,
                   left: 20,
                   right: 20,
                 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       AppLargeText(text: "Trip",),
                        AppText(text: text[index],size: 30,),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: 250,
                          child: AppText(
                            text: textDescription[index],
                            size: 14,
                            color: AppColors.textColor2,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            BlocProvider.of<AppCubits>(context).getData();
                          },
                          child: Container(
                            width: 200,
                              child: Row(children:[
                                ResponsiveButton()
                              ]
                              ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: List.generate(
                          3, (indexDots) {
                             return Container(
                               margin: const EdgeInsets.only(bottom: 2),
                               width: 8,
                               height: index==indexDots?25:8,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(8),
                                 color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3),
                               ),
                             );
                              }),
                    ),
                  ],
                ),
              ),
            );
          }
      ),
    );
  }
}
