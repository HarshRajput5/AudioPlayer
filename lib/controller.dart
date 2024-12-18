import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class MusicController extends GetxController {
  static MusicController get instance => Get.find();
  late AudioPlayer player;
  final isPlay = false.obs;
  final countPrevius = 1.obs;
  final countPlay = 1.obs;
  final countNext = 1.obs;
  final audioDuration = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    player = AudioPlayer();
    await player.setAudioSource(playlist,
        initialIndex: 0, initialPosition: Duration.zero);
  }

  Future<void> toggelplay() async {
    if (isPlay.value) {
      isPlay.value = !isPlay.value;
      await player.pause();
      print('pause');
    } else {
      isPlay.value = !isPlay.value;
      await player.play();
      print('Play');
    }
  }

  Slider customSlider() {
    return Slider(
        value: player.currentIndex!.toDouble(),
        onChanged: (value) {
        });
  }

  // ignore: non_constant_identifier_names
  FlutterSlider GuestSelectionSlider() {
    return FlutterSlider(
      values: [player.currentIndex!.toDouble()],
      min: 0,
      max: player.duration!.inMinutes.toDouble(),
      handler: FlutterSliderHandler(
          child: Icon(Icons.circle,
              color: Color.fromRGBO(151, 101, 202, 1), size: 35),
          foregroundDecoration: BoxDecoration(color: Colors.transparent),
          decoration: BoxDecoration(color: Colors.transparent)),
      trackBar: FlutterSliderTrackBar(
          activeTrackBar:
              BoxDecoration(color: Color.fromRGBO(151, 101, 202, 1))),
      onDragging: (handlerIndex, lowerValue, upperValue) {
      },
    );
  }

  final playlist = ConcatenatingAudioSource(
    // Start loading next item just before reaching it
    useLazyPreparation: true,
    // Customise the shuffle algorithm
    shuffleOrder: DefaultShuffleOrder(),
    // Specify the playlist items
    children: [
      AudioSource.asset('assets/a1.mp3'),
      AudioSource.asset('assets/a2.mp3')
    ],
  );

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
