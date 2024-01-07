import 'package:animal_pagination/Caterogry/APIS.dart';

import 'package:animal_pagination/Screen/imagefullscreen.dart';
import 'package:animal_pagination/Screen/searchUi.dart';
import 'package:animal_pagination/model/photomodel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController scrollController = ScrollController();
  late List<PhotoModel> wallpaper;
  bool isLoading = true;
  getwallpapers() async {
    wallpaper = await APiOperation.getWallpapers();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        ++APiOperation.page;
        getwallpapers();
      }
    });
    getwallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: Text('Wallpaper'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(children: [
                  SearchUI(),
                  Container(
                    margin: EdgeInsets.all(10),
                    height: 700,
                    child: GridView.builder(
                        controller: scrollController,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: 250,
                            crossAxisCount: 3,
                            crossAxisSpacing: 13,
                            mainAxisSpacing: 10),
                        itemCount: wallpaper.length + 1,
                        itemBuilder: (context, index) => (index <
                                wallpaper.length)
                            ? GridTile(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => FullScreen(
                                                img: wallpaper[index].imgscr)));
                                  },
                                  child: Container(
                                    height: 700,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.blueAccent,
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                wallpaper[index].imgscr),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(),
                              )),
                  )
                ]),
              ),
            ),
    );
  }
}
