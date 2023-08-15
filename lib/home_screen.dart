import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/timer_provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(69, 195, 1, 255),
        title: const Text(
          'Flutter Timer',
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TimerProvider(),
        child: Consumer<TimerProvider>(
          builder: (BuildContext context, timerProvider, Widget? child) {
            return Stack(
              children: [
                WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [Colors.blue, Colors.blue.shade200],
                      [Colors.blue.shade400, Colors.blue.shade800],
                    ],
                    durations: [35000, 19440],
                    heightPercentages: [0.1, 0.15],
                    blur: const MaskFilter.blur(BlurStyle.solid, 20),
                  ),
                  waveAmplitude: 30,
                  size: const Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
                Positioned(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${timerProvider.minute.toString().padLeft(2, '0')}:${timerProvider.second.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 50),
                       // timerProvider.isPlaying ?

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (timerProvider.isPlaying) {
                                  timerProvider.stopTimer();
                                } else {
                                  timerProvider.startTimer();
                                }
                              },
                              icon: Icon(
                                timerProvider.isPlaying
                                    ? Icons.pause
                                    : Icons.play_circle,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                timerProvider.resetTimer();
                              },
                              icon: Icon(
                                Icons.refresh,
                                size: 30,
                              ),
                            ),
                          ],
                        )
                            //:
                        // IconButton(
                        //   onPressed: () {
                        //     timerProvider.startTimer();
                        //     if (timerProvider.minute == 0 &&
                        //         timerProvider.second == 0) {
                        //       timerProvider.minute = 1;
                        //       timerProvider.second = 0;
                        //     }
                        //   },
                        //   icon: const Icon(
                        //     Icons.play_circle,
                        //     size: 30,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
