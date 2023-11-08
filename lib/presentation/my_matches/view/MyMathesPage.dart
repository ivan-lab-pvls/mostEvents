// ignore_for_file: library_private_types_in_public_api, file_names, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_review/in_app_review.dart';
import 'AddMatchPage.dart';

late SharedPreferences prefers;
final rateCallView = InAppReview.instance;
Future<void> prefGet() async {
  prefers = await SharedPreferences.getInstance();
}

Future<void> isCallStars() async {
  await prefGet();
  bool rateStated = prefers.getBool('rateStated') ?? false;
  if (!rateStated) {
    if (await rateCallView.isAvailable()) {
      rateCallView.requestReview();
      await prefers.setBool('rateStated', true);
    }
  }
}

class MyMatchesScreen extends StatefulWidget {
  @override
  _MyMatchesScreenState createState() => _MyMatchesScreenState();
}

class _MyMatchesScreenState extends State<MyMatchesScreen> {
  Future<List<Map<String, dynamic>>> loadMatchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? matchDataJsonList = prefs.getStringList('matches');
    if (matchDataJsonList != null) {
      List decodedList = matchDataJsonList
          .map((matchDataJson) => jsonDecode(matchDataJson))
          .toList();
      return decodedList.whereType<Map<String, dynamic>>().toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddMyMatchPage()),
          );
        },
        backgroundColor: const Color(0xFFFC5601),
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .15,
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
                    'assets/images/mytext.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: loadMatchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'You have not any matches, tap "+" button',
                      textAlign: TextAlign.center,
                    ),
                  );
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  List<Map<String, dynamic>> matches = snapshot.data!;
                  return ListView.builder(
                    itemCount: matches.length,
                    itemBuilder: (context, index) {
                      var match = matches[index];
                      return Dismissible(
                        key: Key(match.toString()),
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 20),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        direction: DismissDirection.endToStart,
                        onDismissed: (direction) async {
                          setState(() {
                            matches.removeAt(index);
                          });
                          List<String> updatedMatchesJsonList = matches
                              .map((match) => jsonEncode(match))
                              .toList();
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setStringList(
                              'matches', updatedMatchesJsonList);
                        },
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .16,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
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
                                              match['firstTeam'].toString(),
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
                                              match['secondTeam'].toString(),
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
                                    Column(
                                      children: [
                                        Text(
                                          match['time'].toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 11, 0, 55),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          match['date'].toString(),
                                          style: const TextStyle(
                                            color: Color.fromARGB(255, 11, 0, 55),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
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
                  );
                } else {
                  return const Center(
                    child: Text(
                      'You have not any matches, tap "+" button',
                      textAlign: TextAlign.center,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
