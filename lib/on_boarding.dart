import 'package:flutter/material.dart';
import 'package:on_boarding/cache.dart';
import 'package:on_boarding/home.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  PageController pageController = PageController();
  List<String> headlines = [
    'Nice UI',
    'Good UX',
    'Perfect Design',
  ];
  List<String> descriptions = [
    "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, ",
    "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,",
  ];
  List<String> images = [
    'https://image.freepik.com/free-vector/happy-travelers-going-through-flight-registration-counter-trip-baggage-luggage-flat-vector-illustration-travel-vacation_74855-8405.jpg',
    'https://image.freepik.com/free-vector/online-app-tourism-traveler-with-mobile-phone-passport-booking-buying-plane-ticket_74855-10966.jpg',
    'https://image.freepik.com/free-vector/happy-tourists-choosing-hotel-booking-room-online-flat-illustration_74855-10811.jpg',
    // 'https://image.freepik.com/free-vector/hotel-booking-concept-illustration_114360-2257.jpg',
  ];
  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: headlines.length,
      onPageChanged: (value) {
        if (value == headlines.length - 1) {
          isLast = true;
          
        } else {
          isLast = false;
        }
      },
      itemBuilder: (context, index) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    CacheHelper.saveData(key: 'showBoarding', value: false)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()));
                    });
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                ),
              )
            ],
          ),
          body: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            headlines[index],
                            textDirection: TextDirection.ltr,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 6, 25, 128),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            descriptions[index],
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 56, 79, 193)),
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          headlines.length,
                          (dotsIndex) => Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            width: 8,
                            height: index == dotsIndex ? 25 : 8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: index == dotsIndex
                                    ? Colors.indigo
                                    : Colors.indigo[300]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.network(
                    images[index],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (isLast) {
                CacheHelper.saveData(key: 'showBoarding', value: false)
                    .then((value) {
                  if (value) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                });
              } else {
                pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              }
            },
            child: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
      controller: pageController,
    );
  }
}
