import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My App",
        home: Scaffold(
          appBar: AppBar(
            title: Text("Poet Phleng"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [const SendDem()])),
        ));
  }
}

class Song {
  //modal class for Person object
  String name;
  String linktitle;

  String get title {
    _downloadVideo();
    return linktitle;
  }

  void _downloadVideo() async {
    final yt = YoutubeExplode();
    final video = await yt.videos.get(name);
    linktitle = video.title;
  }

  Song({
    required this.name,
    this.linktitle = "",
  });
}

class SendDem extends StatefulWidget {
  const SendDem({super.key});

  @override
  State<SendDem> createState() => _SendDemState();
}

class _SendDemState extends State<SendDem> {
  final inputtext = TextEditingController();
  String word = '';
  bool _validate = false;

  List<Song> songs = [];

  void initState() {
    //adding item to list, you can add using json from network
    //songs.add(Song(name:"Hari Prasad Chaudhary"));
    //songs.add(Song(name:"Krishna Karki"));
    //songs.add(Song(name:"Ujjwal Josh"));
    super.initState();
  }

  String getYouTubeUrl(String? value) {
    String pattern =
        r'((?:https?:)?\/\/)?((?:www|m)\.)?((?:youtube\.com|youtu.be))(\/(?:[\w\-]+\?v=|embed\/|v\/)?)([\w\-]+)(\S+)?';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value))
      return 'Enter a valid email address';
    else
      return "null";
  }

  

  String getVideoID(String url) {
    url = url.replaceAll("https://www.youtube.com/watch?v=", "");
    url = url.replaceAll("https://m.youtube.com/watch?v=", "");
    url = url.replaceAll("https://youtu.be/", "");
    String urls = "https://img.youtube.com/vi/" + url + "/0.jpg";
    print(urls);
    return urls;
  }

  // Future<String> _downloadVideo(youTubeLink) async {
  //   final yt = YoutubeExplode();
  //   final video = await yt.videos.get(youTubeLink);
  //   String title = video.title;
  //   print(title);

  //   return title;
  // }



  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 50, bottom: 40),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                  width: 310.0,
                  height: 400.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFD9E4FF).withOpacity(0.5),
                        spreadRadius: 1.5,
                        blurRadius: 0,
                        offset: Offset(7, 8), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(children: [
                    SizedBox(height: 12),
                    Text((songs.length).toString() + "/3"),
                    //space
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          children: songs.map((personone) {
                            return Container(
                              child: Card(
                                child: ListTile(
                                  leading: Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                            image: new NetworkImage(
                                                (getVideoID(personone.name))
                                                    .toString()),
                                            fit: BoxFit.cover,
                                          ))),
                                  // title: Text("$_downloadVideo(personone.name)"),
                                  title: Text(personone.title),
                                  trailing: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0)),
                                        minimumSize: Size(30, 50),
                                        backgroundColor: Color(0xFFB0B2FF)),
                                    child: Icon(Icons.delete),
                                    onPressed: () {
                                      //delete action for this button
                                      songs.removeWhere((element) {
                                        return element.name == personone.name;
                                      }); //go through the loop and match content to delete from list
                                      setState(() {
                                        //refresh UI after deleting element from list
                                      });
                                    },
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    )
                  ])),
            )),
        Text(
          "Add song",
          style: TextStyle(fontSize: 20),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65.0, vertical: 20.0),
          child: TextField(
            controller: inputtext,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
              hintText: 'Song url',
              errorText: _validate ? '???' : null,
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFB0B2FF),
            foregroundColor: Colors.white,
            shadowColor: Color(0xFFD9E4FF),
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            minimumSize: Size(130, 50), //////// HERE
          ),
          onPressed: () {
            if (inputtext.text.isEmpty) {
              setState(() {
                inputtext.text.isEmpty ? _validate = true : _validate = false;
              });
            } else if (songs.length == 3) {
              _validate = false;
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text("Alert Bitch!!"),
                          content: Text('Reach out limit'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('Dismiss'))
                          ]));
              inputtext.clear();
            } else {
              setState(() {
                _validate = false;
                word = inputtext.text;
                var a = Song(name: word);
                a.title;
                // print(a.linktitle);
                songs.add(a);
                print(a.title);
                print(songs.length);
                inputtext.clear();
              });
            }
          },
          child: Text(
            'Send >',
            style: new TextStyle(
              fontFamily: "comfortaa",
              fontSize: 18.0,
            ),
          ),
        )
      ],
    );
  }
}
