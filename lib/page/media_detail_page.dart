import 'package:cinematic_flutter/model/cast.dart';
import 'package:cinematic_flutter/model/media.dart';
import 'package:cinematic_flutter/model/media_detail.dart';
import 'package:cinematic_flutter/model/media_type.dart';
import 'package:cinematic_flutter/viewmodel/media_view_model.dart';
import 'package:cinematic_flutter/widget/app_tab_bar.dart';
import 'package:cinematic_flutter/widget/bottom_gradient.dart';
import 'package:cinematic_flutter/widget/cast_section.dart';
import 'package:cinematic_flutter/widget/meta_section.dart';
import 'package:cinematic_flutter/widget/text_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:cinematic_flutter/model/app_tab.dart';
import 'package:cinematic_flutter/widget/media_list.dart';
import 'package:cinematic_flutter/widget/toggle_theme_button.dart';
import 'package:cinematic_flutter/model/app_state.dart';
import 'package:cinematic_flutter/localizations.dart';
import 'package:cinematic_flutter/constants.dart';
import 'package:cinematic_flutter/widget/language_dialog.dart';
import 'package:cinematic_flutter/viewmodel/home_view_model.dart';
import 'package:logging/logging.dart';
import 'package:cinematic_flutter/util/text_util.dart';
import 'package:cinematic_flutter/localizations.dart';

class MediaDetailPage extends StatefulWidget {
  final Media media;

  MediaDetailPage(this.media);

  @override
  State<StatefulWidget> createState() => _MediaDetailState(media);
}

class _MediaDetailState extends State<StatefulWidget> {
  final tagBgColor = Color(0xffF47663);

  final Media media;

  MediaDetail mediaDetail = MediaDetail.fromJson(_createMediaDetail());

  final List<Cast> castList = _createCastList();

  _MediaDetailState(this.media);

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _buildAppBar(context),
            _buildContent(context),
          ],
        ),
      );

  Widget _buildAppBar(BuildContext ctx) => SliverAppBar(
      expandedHeight: 240.0,
      pinned: true,
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.favorite_border,
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Hero(
              tag: 'media_tag_${media.id}',
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/images/placeholder.jpg',
                width: double.infinity,
                image: media.backdropPath,
              ),
            ),
            BottomGradient(),
            _buildMeta(ctx),
          ],
        ),
      ));

  Widget _buildMeta(BuildContext ctx) => AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(
          milliseconds: 500,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  TextBubble(
                    media.releaseDate.year.toString(),
                    backgroundColor: tagBgColor,
                  ),
                  Container(
                    width: 8.0,
                  ),
                  TextBubble(
                    media.voteAverage.toString(),
                    backgroundColor: tagBgColor,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  media.title,
                  style: TextStyle(color: Color(0xFFEEEEEE), fontSize: 20.0),
                ),
              ),
              Row(
                children: getGenresForIds(media.genreIds, ctx)
                    .map((text) => Row(
                          children: <Widget>[
                            TextBubble(text),
                            Container(
                              width: 8.0,
                            ),
                          ],
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );

  Widget _buildContent(BuildContext ctx) => SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(ctx).synopsis,
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Text(
                      media.overview,
                      style: Theme.of(ctx)
                          .textTheme
                          .subhead
                          .copyWith(fontSize: 12.0),
                    ),
                    Container(
                      height: 8.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CastSection(castList),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              padding: EdgeInsets.all(16.0),
              child: MetaSection(mediaDetail),
            ),
          ],
        ),
      );
}

//临时数据
List<Cast> _createCastList() {
  return [
    {
      "cast_id": 1,
      "character": "Tony Stark / Iron Man",
      "credit_id": "54a9cfa29251414d5b00553d",
      "gender": 2,
      "id": 3223,
      "name": "Robert Downey Jr.",
      "order": 0,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/1YjdSym1jTG7xjHSI0yGGWEsw5i.jpg"
    },
    {
      "cast_id": 6,
      "character": "Thor Odinson",
      "credit_id": "54a9d012c3a3680c29005762",
      "gender": 2,
      "id": 74568,
      "name": "Chris Hemsworth",
      "order": 1,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/lrhth7yK9p3vy6p7AabDUM1THKl.jpg"
    },
    {
      "cast_id": 13,
      "character": "Bruce Banner / Hulk",
      "credit_id": "573fc00592514177ec00010a",
      "gender": 2,
      "id": 103,
      "name": "Mark Ruffalo",
      "order": 2,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/isQ747u0MU8U9gdsNlPngjABclH.jpg"
    },
    {
      "cast_id": 2,
      "character": "Steve Rogers / Captain America",
      "credit_id": "54a9cfc0c3a3680c2900575e",
      "gender": 2,
      "id": 16828,
      "name": "Chris Evans",
      "order": 3,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/kRlx7PxXkom7Daj8Z2HmcbPQB1o.jpg"
    },
    {
      "cast_id": 3,
      "character": "Thanos",
      "credit_id": "54a9cfcac3a3680c1e0053ea",
      "gender": 2,
      "id": 16851,
      "name": "Josh Brolin",
      "order": 4,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/x8KKnvHyPvH16M6waAnY1OeCtA8.jpg"
    },
    {
      "cast_id": 72,
      "character": "Stephen Strange / Doctor Strange",
      "credit_id": "5921f8ab92514149f305d2d0",
      "gender": 2,
      "id": 71580,
      "name": "Benedict Cumberbatch",
      "order": 5,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/wz3MRiMmoz6b5X3oSzMRC9nLxY1.jpg"
    },
    {
      "cast_id": 40,
      "character": "Natasha Romanoff / Black Widow",
      "credit_id": "581f354cc3a36860b9005213",
      "gender": 1,
      "id": 1245,
      "name": "Scarlett Johansson",
      "order": 6,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/rzjSlH8UIRtMCz5PLG4sRw1QBCT.jpg"
    },
    {
      "cast_id": 64,
      "character": "Peter Parker / Spider-Man",
      "credit_id": "589237b1c3a368097300b048",
      "gender": 2,
      "id": 1136406,
      "name": "Tom Holland",
      "order": 7,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/kC88TIMh9z73pImu5HpPG6ttuDv.jpg"
    },
    {
      "cast_id": 33,
      "character": "Vision",
      "credit_id": "57eb6d079251415016003ac1",
      "gender": 2,
      "id": 6162,
      "name": "Paul Bettany",
      "order": 8,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/1zmr8C7TCqsoCjDVKJycVp2wWyf.jpg"
    },
    {
      "cast_id": 12,
      "character": "Wanda Maximoff / Scarlet Witch",
      "credit_id": "573fbd48c3a368072200003f",
      "gender": 1,
      "id": 550843,
      "name": "Elizabeth Olsen",
      "order": 9,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/mGyqAs1MwwE4gd490iKxSo193qA.jpg"
    },
    {
      "cast_id": 100,
      "character": "James 'Rhodey' Rhodes / War Machine",
      "credit_id": "59a4b3d3c3a3685148000c61",
      "gender": 2,
      "id": 1896,
      "name": "Don Cheadle",
      "order": 10,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/b1EVJWdFn7a75qVYJgwO87W2TJU.jpg"
    },
    {
      "cast_id": 46,
      "character": "T'Challa / Black Panther",
      "credit_id": "581f3687c3a3685afd0054ac",
      "gender": 2,
      "id": 172069,
      "name": "Chadwick Boseman",
      "order": 11,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/znyHJBN6r0cONV17R26U31R6VqR.jpg"
    },
    {
      "cast_id": 70,
      "character": "Sam Wilson / Falcon",
      "credit_id": "58f6703d9251415dec001fac",
      "gender": 2,
      "id": 53650,
      "name": "Anthony Mackie",
      "order": 12,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/5VGGJ0Co8SC94iiedWb2o3C36T.jpg"
    },
    {
      "cast_id": 17,
      "character": "Bucky Barnes / Winter Soldier",
      "credit_id": "57b7602bc3a36823ba001703",
      "gender": 2,
      "id": 60898,
      "name": "Sebastian Stan",
      "order": 13,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/76Lr7hStv0uunDbCYIXO9pMV8Mb.jpg"
    },
    {
      "cast_id": 16,
      "character": "Peter Quill / Star-Lord",
      "credit_id": "57b76016c3a36823a60015f4",
      "gender": 2,
      "id": 73457,
      "name": "Chris Pratt",
      "order": 14,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/gXKyT1YU5RWWPaE1je3ht58eUZr.jpg"
    },
    {
      "cast_id": 30,
      "character": "Gamora",
      "credit_id": "57eb6c9ac3a3683657002b4a",
      "gender": 1,
      "id": 8691,
      "name": "Zoe Saldana",
      "order": 15,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/ofNrWiA2KDdqiNxFTLp51HcXUlp.jpg"
    },
    {
      "cast_id": 35,
      "character": "Drax the Destroyer",
      "credit_id": "57eb6d44c3a368397e00276d",
      "gender": 2,
      "id": 543530,
      "name": "Dave Bautista",
      "order": 16,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/oZDL1VprkUEFhOtG5WcVjudj5ks.jpg"
    },
    {
      "cast_id": 61,
      "character": "Mantis",
      "credit_id": "588d65d8925141234e006160",
      "gender": 1,
      "id": 139820,
      "name": "Pom Klementieff",
      "order": 17,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/5L0cO2WvhA02k95OPf1jx0F9PbG.jpg"
    },
    {
      "cast_id": 26,
      "character": "Nebula",
      "credit_id": "57eb6b8fc3a36868ba003dad",
      "gender": 1,
      "id": 543261,
      "name": "Karen Gillan",
      "order": 18,
      "profile_path": "/b6rSmkcM3XvSxCb3aLEP8JaG07q.jpg"
    },
    {
      "cast_id": 69,
      "character": "Loki",
      "credit_id": "58c7ad7192514179f700a1be",
      "gender": 2,
      "id": 91606,
      "name": "Tom Hiddleston",
      "order": 19,
      "profile_path": "/qB1lHPFBPIzw6I7EvsciZ5wyUNS.jpg"
    },
    {
      "cast_id": 113,
      "character": "Heimdall",
      "credit_id": "5aad702ec3a36846ba017d6e",
      "gender": 2,
      "id": 17605,
      "name": "Idris Elba",
      "order": 20,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/fBNfIzrfOqh1KFvQkSxrJoMNYXL.jpg"
    },
    {
      "cast_id": 106,
      "character": "Eitri",
      "credit_id": "5aac2e7ec3a36846ba004695",
      "gender": 2,
      "id": 22970,
      "name": "Peter Dinklage",
      "order": 21,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/xuB7b4GbARu4HN6gq5zMqjGbkwF.jpg"
    },
    {
      "cast_id": 38,
      "character": "Wong",
      "credit_id": "580aa9a79251414e7d003366",
      "gender": 2,
      "id": 30082,
      "name": "Benedict Wong",
      "order": 22,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/iBzJ8s7GqgtRfGH3q0Ep5OKnaGf.jpg"
    },
    {
      "cast_id": 29,
      "character": "Rocket Racoon (voice)",
      "credit_id": "57eb6c85c3a36837fe00237f",
      "gender": 2,
      "id": 51329,
      "name": "Bradley Cooper",
      "order": 23,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/z5LUl9bljJnah3S5rtN7rScrmI8.jpg"
    },
    {
      "cast_id": 32,
      "character": "Groot (voice)",
      "credit_id": "57eb6cf6c3a36868bd003830",
      "gender": 2,
      "id": 12835,
      "name": "Vin Diesel",
      "order": 24,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/mjRdM6w6Uz1UnrKQ5Kw02qGln2K.jpg"
    },
    {
      "cast_id": 114,
      "character": "Ayo",
      "credit_id": "5ab4b1b09251417af9017d02",
      "gender": 1,
      "id": 139900,
      "name": "Florence Kasumba",
      "order": 25,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/oLKR9435H3sjeCWWvD0rLGsL5t9.jpg"
    },
    {
      "cast_id": 337,
      "character": "Brian 'Tiny' McKeever",
      "credit_id": "5ae29f91c3a368768302ba09",
      "gender": 0,
      "id": 212003,
      "name": "Ethan Dizon",
      "order": 26,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/2Zqioe3D9Yb4B8dMUcea6Cy6aoQ.jpg"
    },
    {
      "cast_id": 339,
      "character": "Cindy Moon",
      "credit_id": "5ae2a2b10e0a262a67029057",
      "gender": 0,
      "id": 1237601,
      "name": "Tiffany Espensen",
      "order": 27,
      "profile_path":
          "${PROFILE_IMAGE_URL_MEDIUM}/nxXUE2I3vsMNy8iha3PCrnO4wTt.jpg"
    },
  ].map((map) => Cast.fromJsonMap(map)).toList();
}

Map<String, dynamic> _createMediaDetail() => {
      "adult": false,
      "backdrop_path": "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
      "belongs_to_collection": {
        "id": 86311,
        "name": "复仇者联盟（系列）",
        "poster_path": "/qJawKUQcIBha507UahUlX0keOT7.jpg",
        "backdrop_path": "/zuW6fOiusv4X9nnW3paHGfXcSll.jpg"
      },
      "budget": 300000000,
      "genres": [
        {"id": 12, "name": "冒险"},
        {"id": 878, "name": "科幻"},
        {"id": 28, "name": "动作"}
      ],
      "homepage": "http://marvel.com/avengers",
      "id": 299536,
      "imdb_id": "tt4154756",
      "original_language": "en",
      "original_title": "Avengers: Infinity War",
      "overview":
          "《复仇者联盟3：无限战争》是漫威电影宇宙10周年的历史性集结，将为影迷们带来史诗版的终极对决。面对灭霸突然发起的闪电袭击，复仇者联盟及其所有超级英雄盟友必须全力以赴，才能阻止他对全宇宙造成毁灭性的打击。",
      "popularity": 268.201,
      "poster_path": "/oFUedggMEFgdxmkaLwyfku0rJOn.jpg",
      "production_companies": [
        {
          "id": 420,
          "logo_path": "/hUzeosd33nzE5MCNsZxCGEKTXaQ.png",
          "name": "Marvel Studios",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {"iso_3166_1": "US", "name": "United States of America"}
      ],
      "release_date": "2018-04-25",
      "revenue": 2046239637,
      "runtime": 156,
      "spoken_languages": [
        {"iso_639_1": "en", "name": "English"}
      ],
      "status": "Released",
      "tagline": "",
      "title": "复仇者联盟3：无限战争",
      "video": false,
      "vote_average": 8.3,
      "vote_count": 7841
    };
