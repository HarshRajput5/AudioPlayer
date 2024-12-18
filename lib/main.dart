import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicScreen(),
    );
  }
}

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MusicController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Music App',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.my_library_music_sharp,size: 200,),
              // controller.customSlider(),
              // Obx(() => controller.GuestSelectionSlider()),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          controller.player.seekToPrevious();
                          controller.countPrevius.value++;
                          print(
                              "previus count ${controller.countPrevius.value}");
                        },
                        icon: Icon(Icons.arrow_back_ios)),
                    IconButton(
                        onPressed: () {
                          // if(controller.isPlay.value){
                          //   controller.player.pause();
                          // }
                          // else{
                          //   controller.player.play();
                          // }
                          controller.toggelplay();
                          controller.countPlay.value++;
                          print("Play count ${controller.countPlay.value}");
                        },
                        icon: Icon(controller.isPlay.value
                            ? Icons.pause
                            : Icons.play_arrow)),
                    IconButton(
                        onPressed: () {
                          controller.player.seekToNext();
                          controller.countNext.value++;
                          print("Next count ${controller.countNext.value}");
                        },
                        icon: Icon(Icons.arrow_forward_ios))
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.player.currentIndex.toString()),
                  Text(controller.player.duration.toString())
                ],
              ),
              // Obx(
              //   ()=> ElevatedButton(
              //     onPressed: ()=>controller.toggelplay(),
              //     child: Text(controller.isPlay.value ? 'Pause' : 'Play'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
