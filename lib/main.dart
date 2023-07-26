import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/notification.dart';
import 'package:instagram/style.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'shop.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(ChangeNotifierProvider(
    create: (c) => Store1(),
    child: MaterialApp(
      theme: theme,
      home: MyApp(),
    ),
  ));
}

var a = TextStyle();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;
  var data = [];
  var userImage;
  var userContent;

  setUserContent(a) {
    setState(() {
      userContent = a;
    });
  }

  addMyData() {
    var myData = {
      'id': data.length,
      'image': userImage,
      'likes': 0,
      'date': 'July 2',
      'content': userContent,
      'liked': false,
      'user': 'Me'
    };
    setState(() {
      data.insert(0, myData);
    });
  }

  @override
  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/data.json'));
    var result2 = jsonDecode(result.body);
    print(result2);
    setState(() {
      data = result2;
    });
  }

  addMoreToData(a) {
    setState(() {
      data.add(a);
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    initNotification(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          showNotification2();
        },
      ),
      appBar: AppBar(
        title: Container(
          child: Text(
            'Instagram',
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_box_outlined),
            onPressed: () async {
              var picker = ImagePicker();
              var image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                setState(() {
                  userImage = File(image.path);
                });
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) {
                    return Upload(
                        userImage: userImage,
                        setUserContent: setUserContent,
                        addMyData: addMyData);
                  },
                ),
              );
            },
          )
        ],
      ),
      body: [
        Home(data: data, addMoreToData: addMoreToData),
        Shop(),
      ][tab],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (i) {
          setState(() {
            tab = i;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined), label: '샵'),
        ],
      ),
    );
  }
}

class Upload extends StatelessWidget {
  Upload({Key? key, this.userImage, this.setUserContent, this.addMyData})
      : super(key: key);
  final userImage;
  final addMyData;
  final setUserContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.file(userImage),
          Text('이미지업로드화면'),
          TextField(
            onChanged: (text) {
              setUserContent(text);
            },
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              IconButton(
                onPressed: () {
                  addMyData();
                },
                icon: Icon(Icons.check),
              ),
            ],
          )
        ]));
  }
}

class Home extends StatefulWidget {
  Home({super.key, this.data, this.addMoreToData});

  final data;
  final addMoreToData;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var scroll = ScrollController();
  var more;
  getMore() async {
    var resultM = await http
        .get(Uri.parse('https://codingapple1.github.io/app/more1.json'));
    var resultMore = jsonDecode(resultM.body);
    print(resultMore);
    print('maximum');
    widget.addMoreToData(resultMore);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scroll.addListener(() {
      if (scroll.position.pixels == scroll.position.maxScrollExtent) {
        getMore();

        print(widget.data.length);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isNotEmpty) {
      return ListView.builder(
        itemCount: widget.data.length,
        controller: scroll,
        itemBuilder: (c, i) {
          return Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.data[i]['image'].runtimeType == String
                        ? Image.network(widget.data[i]['image'])
                        : Image.file(widget.data[i]['image']),
                    GestureDetector(
                      child: Text(widget.data[i]['user']),
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (c, a1, a2) => Profile(),
                              transitionsBuilder: (c, a1, a2, child) =>
                                  SlideTransition(
                                    position: Tween(
                                      begin: Offset(1.0, 0.0),
                                      end: Offset(0.0, 0.0),
                                    ).animate(a1),
                                    child: child,
                                  )),
                        );
                      },
                    ),
                    Text('좋아요 ${widget.data[i]['likes']}'),
                    Text(widget.data[i]['date']),
                    Text(
                      widget.data[i]['content'],
                    ),
                  ],
                ),
              )
            ],
          );
        },
      );
    } else {
      return Text('Loading..');
    }
  }
}

fontsize1(context) {
  if (MediaQuery.of(context).size.width > 600) {
    return 30;
  } else {
    return 16;
  }
}

class Store1 extends ChangeNotifier {
  var name = 'john kim';
  var follower = 0;
  var follow = false;
  var profileImage = [];

  getData() async {
    var result = await http
        .get(Uri.parse('https://codingapple1.github.io/app/profile.json'));
    var result2 = jsonDecode(result.body);
    profileImage = result2;
    notifyListeners();
  }

  changeName() {
    name = 'john park';
    notifyListeners();
  }

  addFollower() {
    if (follow == false) {
      follower++;
      follow = true;
    } else {
      follower--;
      follow = false;
    }

    notifyListeners();
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Text(context.watch<Store1>().name),
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileHeader(),
            ),
            SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (c, i) =>
                      Image.network(context.watch<Store1>().profileImage[i]),
                  childCount: context.watch<Store1>().profileImage.length,
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3)),
          ],
        ));
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
        ),
        Text('팔로워 ${context.watch<Store1>().follower}명'),
        ElevatedButton(
            onPressed: () {
              context.read<Store1>().addFollower();
            },
            child: Text('follow')),
        ElevatedButton(
            onPressed: () {
              context.read<Store1>().getData();
            },
            child: Text('get image'))
      ],
    );
  }
}
