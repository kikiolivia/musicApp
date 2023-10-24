import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key, required this.data}) : super(key: key);
  final List<SongModel> data;

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz,
              color: blackColor,
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: blackColor,
          ),
        ),
        title: Center(
          child: Text(
            'Now Playing',
            style: ourStyle(
              family: 'bold',
              size: 21,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 250,
              width: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: blackColor,
              ),
              alignment: Alignment.center,
              child: QueryArtworkWidget(
                id: data[controller.playIndex.value].id,
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: const Icon(
                  Icons.music_note,
                  size: 42,
                  color: bgColor,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
                color: dayColor,
              ),
              child: Obx(
                () => Column(
                  children: [
                    Text(
                      data[controller.playIndex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: ourStyle(
                        color: blackColor,
                        family: bold,
                        size: 24,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      data[controller.playIndex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: ourStyle(
                        color: blackColor,
                        family: regular,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => Container(
                        margin:
                            const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.position.value,
                              style: ourStyle(
                                color: blackColor,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                thumbColor: sliderColor,
                                inactiveColor: blackColor,
                                activeColor: sliderColor,
                                min: const Duration(seconds: 0)
                                    .inSeconds
                                    .toDouble(),
                                max: controller.max.value,
                                value: controller.value.value,
                                onChanged: (newValue) {
                                  controller.changeDurationToSeconds(
                                      newValue.toInt());
                                  newValue = newValue;
                                },
                              ),
                            ),
                            Text(
                              controller.duration.value,
                              style: ourStyle(
                                color: blackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            controller.playSong(
                                data[controller.playIndex.value - 1].uri,
                                controller.playIndex.value - 1);
                          },
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 40,
                            color: blackColor,
                          ),
                        ),
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: blackColor,
                          child: Transform.scale(
                            scale: 3,
                            child: IconButton(
                              onPressed: () {
                                if (controller.isPlaying.value) {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying(false);
                                } else {
                                  controller.audioPlayer.play();
                                  controller.isPlaying(true);
                                }
                              },
                              icon: controller.isPlaying.value
                                  ? const Icon(
                                      Icons.pause,
                                      color: bgColor,
                                    )
                                  : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: bgColor,
                                    ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.playSong(
                                data[controller.playIndex.value + 1].uri,
                                controller.playIndex.value + 1);
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            size: 40,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
