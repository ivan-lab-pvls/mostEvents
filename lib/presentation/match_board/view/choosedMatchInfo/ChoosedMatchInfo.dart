// ignore_for_file: file_names

import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:most_sport/presentation/match_board/data/indexesPrediction.dart';
import 'package:most_sport/widgets/other/predictionsRate.dart';
import 'package:most_sport/widgets/shareApp/shareAppWidget.dart';

class ChoosedMatchInfo extends StatefulWidget {
  final String teamHome;
  final String teamAway;
  final String leagueName;
  final String time;

  const ChoosedMatchInfo(
      {super.key,
      required this.teamHome,
      required this.teamAway,
      required this.leagueName,
      required this.time});

  @override
  State<ChoosedMatchInfo> createState() => _ChoosedMatchInfoState();
}

class _ChoosedMatchInfoState extends State<ChoosedMatchInfo> {
  int id1 = getRandomInt();
  int id2 = getRandomInt();
  int id3 = getRandomInt();

  final AnimatedButtonController _controller = AnimatedButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                width: 0,
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  CupertinoIcons.back,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              const Text(
                'Match Playground',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  shareApp(context);
                },
                child: const Icon(
                  CupertinoIcons.share,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Container(
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.time,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.leagueName,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child:
                                  Image.asset('assets/images/ball_green.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.teamHome,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 11, 0, 55),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image.asset('assets/images/ball_red.png'),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              widget.teamAway,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 11, 0, 55),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      widget.time,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 11, 0, 55),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AnimatedButtonBar(
            controller: _controller,
            radius: 20.0,
            padding: const EdgeInsets.all(16.0),
            backgroundColor: const Color.fromARGB(255, 231, 231, 232),
            foregroundColor: const Color.fromARGB(255, 255, 166, 13),
            borderWidth: 2,
            innerVerticalPadding: 16,
            children: [
              ButtonBarEntry(
                onTap: () {},
                child: const Text(
                  'Info',
                  style: TextStyle(
                    color: Color.fromARGB(255, 9, 8, 36),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              ButtonBarEntry(
                onTap: () {},
                child: const Text(
                  'Standing',
                  style: TextStyle(
                    color: Color.fromARGB(255, 9, 8, 36),
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Prediction',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Total',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  double indexPrediction = getRandomDouble();

                  return ContainerPrediction(
                    index: indexPrediction,
                    colorBack: index == id1
                        ? const Color.fromARGB(255, 255, 82, 7)
                        : const Color.fromARGB(255, 222, 223, 223),
                    colorText: index == id1
                        ? const Color.fromARGB(255, 222, 223, 223)
                        : const Color.fromARGB(255, 11, 3, 39),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '1st time',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  double indexPrediction = getRandomDouble();

                  return ContainerPrediction(
                    index: indexPrediction,
                    colorBack: index == id2
                        ? const Color.fromARGB(255, 255, 82, 7)
                        : const Color.fromARGB(255, 222, 223, 223),
                    colorText: index == id2
                        ? const Color.fromARGB(255, 222, 223, 223)
                        : const Color.fromARGB(255, 11, 3, 39),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '2nd time',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                itemCount: 3,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  double indexPrediction = getRandomDouble();

                  return ContainerPrediction(
                    index: indexPrediction,
                    colorBack: index == id3
                        ? const Color.fromARGB(255, 255, 82, 7)
                        : const Color.fromARGB(255, 222, 223, 223),
                    colorText: index == id3
                        ? const Color.fromARGB(255, 222, 223, 223)
                        : const Color.fromARGB(255, 11, 3, 39),
                  );
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                'Form',
                style: TextStyle(
                  color: Color.fromARGB(255, 11, 0, 55),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .2,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color.fromARGB(255, 22, 92, 168),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/ball_green.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        widget.teamHome,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * .31,
                        child: Image.asset(
                          'assets/images/frame.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Image.asset(
                            'assets/images/ball_red.png',
                            height: 40,
                            width: 40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        widget.teamAway,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 5.0,
                      ),
                      SizedBox(
                        height: 20,
                        width: MediaQuery.of(context).size.width * .31,
                        child: Image.asset(
                          'assets/images/frame.png',
                          fit: BoxFit.contain,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 0,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
    );
  }
}
