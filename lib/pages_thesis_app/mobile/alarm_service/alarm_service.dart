import 'package:accounts/pages_thesis_app/mobile/home_page.dart';
import 'package:accounts/sound_image_code/sound_images_code.dart';
import 'package:accounts/utility/error_dialog.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devstool show log;

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

import 'alarm_btn.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({
    Key? key,
  }) : super(key: key);

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with TickerProviderStateMixin {
  bool? codeStopperOn;
  bool? isFIrstAlarmOn;
  bool? isSendReport, disScreen;
  bool? isSecAlarmOn;

  late AnimationController controller;

  bool isPlaying = false;
  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  double progress = 1.0;

  void notify() {
    if (countText == '00:00' && isFIrstAlarmOn!) {
      controller.reset();

      devstool.log("First Alarm Code");
      FlutterRingtonePlayer.play(
          volume: 1,
          looping: true,
          fromAsset: soundAlarm, // will be the sound on Android
          ios: IosSounds.glass // will be the sound on iOS
          );
      controller.duration = const Duration(seconds: 30);
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);

      setState(() {
        isFIrstAlarmOn = false;
        isSecAlarmOn = true;
      });
    } else if (countText == '00:00' && isSecAlarmOn!) {
      FlutterRingtonePlayer.stop();
      controller.reset();
      controller.duration = const Duration(seconds: 10);
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
      setState(() {
        isSecAlarmOn = false;
        isSendReport = true;
      });
    } else if (countText == '00:00' && isSendReport!) {
      FlutterRingtonePlayer.play(
          volume: 1,
          looping: true,
          fromAsset: soundAlarm, // will be the sound on Android
          ios: IosSounds.glass // will be the sound on iOS
          );
      controller.reset();
      controller.duration = const Duration(seconds: 30);
      controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
      setState(() {
        disScreen = true;
        isSendReport = false;
      });
    } else if (countText == '00:00' && disScreen!) {
      setState(() {
        HomePage.alarmState = true;
      });
      FlutterRingtonePlayer.stop();
      controller.reset();
      Navigator.pop(context);
      showRerscuerDialog(
          context, "You Reported An Incident To 911 Wait For The Rescue");
    }
  }

  @override
  void initState() {
    super.initState();
    disScreen ??= false;
    isSendReport ??= false;
    codeStopperOn ??= false;
    isSecAlarmOn ??= false;
    isFIrstAlarmOn ??= true;
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
    controller.reverse(from: controller.value == 0 ? 1.0 : controller.value);
    controller.addListener(() {
      notify();

      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
          isPlaying = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO CUSTOMIZE THE UI
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 300,
                  height: 300,
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                    backgroundColor: Colors.grey.shade300,
                    value: progress,
                    strokeWidth: 25,
                  ),
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (context, child) => Text(
                    countText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.width / 2),
                child: FloatingActionButton.extended(
                  heroTag: null,
                  backgroundColor: const Color.fromARGB(255, 250, 14, 14),
                  label: const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Color.fromARGB(221, 250, 250, 250),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  onPressed: () async {
                    controller.reset();
                    FlutterRingtonePlayer.stop();
                    setState(() {
                      HomePage.alarmState = true;
                    });

                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
