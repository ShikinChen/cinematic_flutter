import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/widget/bottom_gradient.dart';
import 'package:flutter/material.dart';

class CastCard extends StatelessWidget {
  final Cast cast;
  final double width;
  final double height;
  final Color salmon = const Color(0xFFF47663);

  CastCard(
    this.cast, {
    this.height: 140.0,
    this.width: 100.0,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {},
        child: Container(
          height: height,
          width: width,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: 'cast_tag_${cast.id}',
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/placeholder.jpg',
                  image: cast.profilePath,
                  fit: BoxFit.cover,
                  height: height,
                  width: width,
                ),
              ),
              BottomGradient.noOffset(),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      cast.name,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 10.0,
                            color: Colors.white,
                          ),
                    ),
                    Container(
                      height: 4.0,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Icon(
                            Icons.person,
                            color: salmon,
                            size: 10.0,
                          ),
                        ),
                        Container(
                          width: 4.0,
                        ),
                        Expanded(
                          flex: 8,
                          child: Text(
                            cast.character,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.subhead.copyWith(
                                  color: Colors.grey,
                                  fontSize: 8.0,
                                ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
