import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:optical_salon/constants.dart';
import 'package:optical_salon/models/news.dart';

class PrimaryCard extends StatelessWidget {
  final News news;
  const PrimaryCard({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      width: 300.0,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Color(0xFF00A693), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 5.0,
                backgroundColor: Color(0xFF00A693),
              ),
              SizedBox(width: 10.0),
              Text(
                news.category,
                style: kCategoryTitle,
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: Hero(
              tag: news.image,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  image: DecorationImage(
                    image: NetworkImage(news.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            news.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: kTitleCard,
          ),
          SizedBox(height: 5.0),
          Row(
            children: [
              Text(
                news.date,
                style: kDetailContent,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
