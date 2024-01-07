import 'package:animal_pagination/Caterogry/APIS.dart';
import 'package:animal_pagination/Screen/homepage.dart';
import 'package:animal_pagination/Screen/imagefullscreen.dart';
import 'package:animal_pagination/model/photomodel.dart';
import 'package:flutter/material.dart';

class SearchCategory extends StatefulWidget {
  String query;
  SearchCategory({super.key, required this.query});

  @override
  State<SearchCategory> createState() => _SearchCategoryState();
}

class _SearchCategoryState extends State<SearchCategory> {
  ScrollController scrollController = ScrollController();
  List<PhotoModel> searchresult = [];
  bool isLoading = true;
  getsearchresult() async {
    searchresult = await APiOperation.searchWallpapers(widget.query);
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
        ++APiOperation.pagesearch;
        getsearchresult();
      }
    });
    getsearchresult();
  }

  late int n = searchresult.length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        title: Text(widget.query.toUpperCase()),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : n == 0
              ? Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text.rich(TextSpan(children: [
                          TextSpan(
                              text: 'We could not find anything for \n',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                          TextSpan(
                              text: widget.query,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.grey)),
                          TextSpan(
                              text: " .\n",
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                          TextSpan(
                              text: 'Try to refine your search\n',
                              style:
                                  TextStyle(fontSize: 30, color: Colors.black)),
                        ])),
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) => HomePage()));
                          },
                          child: Center(
                            child: Text('Go to the main page',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold)),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Container(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: NetworkImage(
                                  searchresult[searchresult.length - 1].imgscr),
                              fit: BoxFit.cover,
                            )),
                          ),
                          Positioned(
                              left: MediaQuery.of(context).size.width / 3.5,
                              top: 25,
                              child: Column(
                                children: [
                                  Text(
                                    'Category',
                                    style: TextStyle(
                                        fontSize: 50,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    widget.query,
                                    style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 600,
                        child: GridView.builder(
                            controller: scrollController,
                            physics: BouncingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisExtent: 250,
                                    crossAxisSpacing: 13,
                                    mainAxisSpacing: 10),
                            itemCount: searchresult.length + 1,
                            itemBuilder: (context, index) => (index <
                                    searchresult.length)
                                ? GridTile(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => FullScreen(
                                                    img: searchresult[index]
                                                        .imgscr)));
                                      },
                                      child: Container(
                                        height: 800,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.blueGrey,
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    searchresult[index].imgscr),
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
