import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/const/colors.dart';
import 'package:music_player/const/text_style.dart';
import 'package:music_player/controllers/player_controller.dart';
import 'package:music_player/pages/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: blackColor,
              ),
            ),
          ],
          // leading: const Icon(
          //   Icons.sort_rounded,
          //   color: blackColor,
          // ),
          title: Text(
            'MusicPlayer',
            style: ourStyle(
              family: 'bold',
              size: 32,
              color: blackColor,
            ),
          ),
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 0.0,
                        color: bgColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: yellowColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Overview',
                        style: ourStyle(
                          family: 'bold',
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 0.0,
                        color: bgColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: bgColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Songs',
                        style: ourStyle(
                          family: 'bold',
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 0.0,
                        color: bgColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: bgColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Album',
                        style: ourStyle(
                          family: 'bold',
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 0.0,
                        color: bgColor,
                      ),
                    ),
                    onPressed: () {},
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 1.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: 2.0,
                            color: bgColor,
                          ),
                        ),
                      ),
                      child: Text(
                        'Artist',
                        style: ourStyle(
                          family: 'bold',
                          size: 16,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                future: controller.audioQuery.querySongs(
                  ignoreCase: true,
                  orderType: OrderType.ASC_OR_SMALLER,
                  sortType: null,
                  uriType: UriType.EXTERNAL,
                ),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.data == null) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text(
                        'No Song Found',
                        style: ourStyle(),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Obx(
                                () => ListTile(
                                  onTap: () {
                                    Get.to(
                                      () => PlayerScreen(data: snapshot.data!),
                                    );
                                    if (!controller.isPlaying.value) {
                                      controller.playSong(
                                          snapshot.data![index].uri, index);
                                    }
                                  },
                                  tileColor: dayColor,
                                  title: Text(
                                    snapshot.data![index].title,
                                    style: ourStyle(
                                      family: 'bold',
                                      size: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    snapshot.data![index].artist.toString(),
                                    style: ourStyle(
                                      family: regular,
                                      size: 12,
                                    ),
                                  ),
                                  leading: QueryArtworkWidget(
                                    id: snapshot.data![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const Icon(
                                      Icons.music_note,
                                      color: blackColor,
                                      size: 32,
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      if (controller.isPlaying.value) {
                                        controller.audioPlayer.pause();
                                        controller.isPlaying(false);
                                      } else {
                                        controller.playSong(
                                            snapshot.data![index].uri, index);
                                        controller.audioPlayer.play();
                                        controller.isPlaying(true);
                                      }
                                    },
                                    icon: controller.playIndex.value == index &&
                                            controller.isPlaying.value
                                        ? const Icon(
                                            Icons.pause,
                                            color: blackColor,
                                            size: 26,
                                          )
                                        : const Icon(
                                            Icons.play_arrow,
                                            color: blackColor,
                                            size: 26,
                                          ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
