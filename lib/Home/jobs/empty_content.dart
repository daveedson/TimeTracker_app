import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    this.title = 'Nothing here',
    this.messages = 'Add a new Item to get Started',
  }) : super(key: key);
  final String title;
  final String messages;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          height: 250,
          width: 250,
          child: Center(
            child: Image.asset('images/arabica.png'),
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 29.0,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          messages,
          style: TextStyle(
            fontSize: 26.0,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
