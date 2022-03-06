import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'package:record_app/models/Album.dart';
import 'package:record_app/models/Track.dart';
import 'package:record_app/providers/media_provider.dart';
import 'package:record_app/screens/HomeScreen.dart';
import 'package:record_app/widgtes/Common/my_loader.dart';
import './widgets/my_text_field.dart';

class AdminAddPodcast extends StatefulWidget {
  @override
  State<AdminAddPodcast> createState() => _AdminAddPodcastState();
}

class _AdminAddPodcastState extends State<AdminAddPodcast> {
  List<File> audioFiles = [];
  File cover;
  String title;
  String description;
  List<Track> tracks = [];
  List<String> descriptions = [];
  List<String> names = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            Get.to(() => HomeScreen());
          },
        ),
        elevation: 0,
        title: Text(
          'Add Audio',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          ListView(padding: EdgeInsets.symmetric(horizontal: 15), children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: GestureDetector(
                onTap: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    cover = File(result.files.single.path);
                    setState(() {});
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor.withOpacity(0.4),
                  ),
                  child: cover == null
                      ? Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 30,
                            ),
                            SizedBox(height: 5),
                            Text('Select cover Image'),
                          ],
                        ))
                      : Image.file(
                          cover,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            SizedBox(height: 15),
            myTextField(
                hint: 'Title',
                onChanged: (val) {
                  setState(() {
                    title = val;
                  });
                }),
            SizedBox(height: 15),
            myTextField(
                hint: 'Description',
                onChanged: (val) {
                  setState(() {
                    description = val;
                  });
                }),
            SizedBox(height: 15),
            Text(
              'Add Tracks',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 5),
            ...List.generate(
              tracks.length,
              (index) => Row(
                children: [
                  InkWell(
                    onTap: () async {
                      FilePickerResult result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);

                      if (result != null) {
                        audioFiles =
                            result.paths.map((path) => File(path)).toList();
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    },
                    child: Container(
                      color: Theme.of(context).cardColor,
                      padding: EdgeInsets.all(25),
                      child: Icon(Icons.music_note),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: myTextField(hint: 'Title'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            if (audioFiles.length == 0)
              InkWell(
                onTap: () async {
                  FilePickerResult result =
                      await FilePicker.platform.pickFiles(allowMultiple: true);

                  if (result != null) {
                    audioFiles =
                        result.paths.map((path) => File(path)).toList();
                    setState(() {});
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  color: Theme.of(context).cardColor,
                  padding: EdgeInsets.all(25),
                  child: Icon(Icons.music_note),
                ),
              ),
            ...List.generate(audioFiles.length, (index) {
              descriptions.add('');
              names.add('');

              return albumAudioTile(audioFiles[index], index);
            }),
            SizedBox(
              height: 60,
            ),
          ]),
          Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  List<String> trackurls = [];
                  final result = await FirebaseStorage.instance
                      .ref('covers/${DateTime.now().toIso8601String()}')
                      .putFile(cover);
                  final url = await result.ref.getDownloadURL();

                  await Future.wait(audioFiles.map((file) async {
                    final result = await FirebaseStorage.instance
                        .ref('audios/${DateTime.now().toIso8601String()}')
                        .putFile(file);
                    final url = await result.ref.getDownloadURL();
                    trackurls.add(url);
                  }));
                  final trackList = trackurls
                      .map((e) => Track(
                            trackurls.indexOf(e),
                            // descriptions[trackurls.indexOf(e)],
                            names[trackurls.indexOf(e)],
                            descriptions[trackurls.indexOf(e)],
                            trackurls[trackurls.indexOf(e)],
                            url,
                            null,
                            DateTime.now().toIso8601String(),
                          ))
                      .toList();

                  print(trackList.first.toJson());

                  try {
                    await Provider.of<MediaProvider>(context, listen: false)
                        .uploadMedia(Album(
                            DateTime.now().millisecondsSinceEpoch,
                            title,
                            description,
                            url,
                            trackList));
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                  }

                  setState(() {
                    isLoading = false;
                  });
                  Navigator.of(context).pop();

                  await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Uploaded'),
                  ));
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: isLoading
                        ? MyLoader()
                        : Text(
                            'Upload',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  Widget audioWidget(File file) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Text(file.path.split('/').last),
          Spacer(),
          InkWell(
            onTap: () {
              audioFiles.remove(file);
              setState(() {});
            },
            child: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }

  Widget albumAudioTile(File file, int index) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              FilePickerResult result =
                  await FilePicker.platform.pickFiles(allowMultiple: false);

              if (result != null) {
                setState(() {
                  audioFiles.add(File(result.paths.first));
                });
              } else {
                // User canceled the picker
              }
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Icon(Icons.music_note),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(file.path.split('/').last),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        audioFiles.remove(file);
                        setState(() {});
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                myTextField(
                    hint: 'Name of audio',
                    onChanged: (val) {
                      print(index);
                      setState(() {
                        names[index] = val;
                      });
                    }),
                SizedBox(height: 10),
                myTextField(
                    hint: 'Subtitles',
                    onChanged: (val) {
                      print(index);
                      setState(() {
                        descriptions[index] = val;
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
