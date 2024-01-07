import 'package:animal_pagination/Screen/SearchCetogry.dart';

import 'package:flutter/material.dart';

class SearchUI extends StatefulWidget {
  const SearchUI({super.key});

  @override
  State<SearchUI> createState() => _SearchUIState();
}

class _SearchUIState extends State<SearchUI> {
  TextEditingController _searchcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchcontroller,
              decoration: InputDecoration(
                  hintText: 'Search ....',
                  errorBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: InputBorder.none),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SearchCategory(
                              query: _searchcontroller.text,
                            )));
               
              },
              child: Icon(Icons.search)),
        ],
      ),
    );
  }
}
