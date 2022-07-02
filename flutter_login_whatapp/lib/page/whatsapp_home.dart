import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'whatapp/call_screen.dart';
import 'whatapp/camera_screen.dart';
import 'whatapp/chat_screen.dart';
import 'whatapp/status_screen.dart';

class WhatsAppHome extends StatefulWidget {
  const WhatsAppHome({Key? key}) : super(key: key);

  @override
  State<WhatsAppHome> createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  List<CameraDescription>? cameras;
  TabController? _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    getCameras();

    _tabController = TabController(vsync: this, initialIndex: 2, length: 4);
    _tabController?.addListener(() {
      if (_tabController?.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: const <Widget>[
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
        actions: const <Widget>[
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CameraScreen(),
          ChatScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).toggleableActiveColor,
              child: const Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () => print("open chats"),
            )
          : null,
    );
  }

  void getCameras() async {
    cameras = await availableCameras();
  }
}
