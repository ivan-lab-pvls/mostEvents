// ignore_for_file: file_names, library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:intl/intl.dart';
import 'package:most_sport/presentation/match_board/data/data.dart';
import 'package:most_sport/presentation/match_board/helpDeskView.dart';
import 'package:most_sport/presentation/match_board/view/choosedMatchInfo/ChoosedMatchInfo.dart';

class MatchBoardScreen extends StatefulWidget {
  const MatchBoardScreen({super.key});

  @override
  _MatchBoardScreenState createState() => _MatchBoardScreenState();
}

class _MatchBoardScreenState extends State<MatchBoardScreen> {
  final DataRepository dataRepository = DataRepository();
  void show() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext cont) {
          return CupertinoActionSheet(
            actions: [
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpDeskView(show: 'https://docs.google.com/document/d/1CnwRrOI6N-aiLvxzBhYhqQBETd6CyLfH0sEwkMR4hVg/edit?usp=sharing',),
                    ),
                  );
                },
                child: const Text('Privacy Policy'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpDeskView(show:'https://docs.google.com/document/d/1mIXnFSDeCL_7DeM4zomzQpXWuG5BBiC8xtDDdGD_Jmc/edit?usp=sharing')));
                },
                child: const Text('Terms & Conditions'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpDeskView(show:'https://forms.gle/TENcNfZ7Mu2LfniYA')));
                },
                child: const Text('Write Support'),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                 InAppReview.instance.openStoreListing(appStoreId: '6471849077',);
                },
                child: const Text('Rate application'),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.of(cont).pop(); // Call the pop method
              },
              child: const Text('Cancel', style: TextStyle(color: Colors.red)),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: dataRepository.fetchData(),
        builder: (context, snapshot) {
          var matchData = snapshot.data;
          int length = 1;
          String time = '';
          String timeLeft = '';
          if (matchData != null) {
            length = matchData.length;
            DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                snapshot.data!['response'][0]['fixture']['timestamp'] * 1000);
            time = DateFormat.Hm().format(dateTime);
            Duration remainingTime = dateTime.difference(DateTime.now());

            int hours = remainingTime.inHours * -1;
            int minutes = remainingTime.inMinutes.remainder(60) * -1;

            timeLeft = 'Starts in ${hours}h ${minutes}mins';
          } else {}

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Text(
                'No matches on this day.\nCreate our match or choose another day!');
          } else {
            return ListView(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .2,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .14,
                        width: MediaQuery.of(context).size.width * .4,
                        child: Image.asset(
                          'assets/images/text.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: show,
                            child: const Icon(
                              CupertinoIcons.settings_solid,
                              color: Colors.grey,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 30,
                            width: 70,
                            child: Image.asset('assets/images/stat_foot.png'),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 30,
                      width: 70,
                      child: Image.asset('assets/images/stat_today.png'),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1.2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChoosedMatchInfo(
                                  teamHome: snapshot.data!['response'][index]
                                          ['teams']['home']['name']
                                      .toString(),
                                  teamAway: snapshot.data!['response'][index]
                                          ['teams']['away']['name']
                                      .toString(),
                                  leagueName: snapshot.data!['response'][index]
                                          ['league']['name']
                                      .toString(),
                                  time: time,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
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
                                      timeLeft,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      snapshot.data!['response'][index]
                                              ['league']['name']
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    SizedBox(
                                        height: 15,
                                        width: 15,
                                        child: Image.asset(
                                            'assets/images/ball_green.png')),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Image.asset(
                                                  'assets/images/ball_green.png'),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data!['response'][index]
                                                      ['teams']['home']['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 11, 0, 55),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: Image.asset(
                                                  'assets/images/ball_red.png'),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              snapshot.data!['response'][index]
                                                      ['teams']['away']['name']
                                                  .toString(),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 11, 0, 55),
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
                                      time,
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
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
