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
import 'package:cinematic_flutter/widget/similar_section.dart';

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

  final List<Media> similarMedia = _createSimilarMedia();

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
            Container(
              decoration:
                  BoxDecoration(color: Theme.of(ctx).scaffoldBackgroundColor),
              child: SimilarSection(similarMedia),
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

List<Media> _createSimilarMedia() => [
      {
        "adult": false,
        "backdrop_path": "/pkX4ytzAXswpMhea0JKxgA5Vmqo.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 1452,
        "original_language": "en",
        "original_title": "Superman Returns",
        "overview":
            "　　一直想寻根的超人（Brandon Routh饰）返回了氪星，希望可以找到其他同伴，但那里的一切早已不复存在。而这一去便是5年。　　5年后，超人回到了地球，但是周遭的一切已经改变。他发现地球已经习惯了没有超人的保护，他一直爱慕的路易丝（Kate Bosworth饰）因为馔写了一篇“为什么世界不需要超人”的报道而获得普利策大奖。更令他心碎的是，她已经与主编的侄子订婚，而且是一个5岁孩子的母亲了。　　另一边，他的死对头莱克斯（Kevin Spacey饰）利用卑鄙手段骗取了巨额遗产，企图卷土重来。在南极莱克斯找到了超人父亲的线索，以及一块含有超级能量的水晶，妄想借助水晶的力量控制地球。　　超人能否战胜心魔，再一次挽救地球于水火？",
        "poster_path": "${IMAGE_URL_MEDIUM}/e3aLTaD5ppxo3en0GAGceekEPAe.jpg",
        "release_date": "2006-06-28",
        "title": "超人归来",
        "video": false,
        "vote_average": 5.5,
        "vote_count": 1969,
        "popularity": 26.772
      },
      {
        "id": 1924,
        "video": false,
        "vote_count": 1517,
        "vote_average": 7,
        "title": "超人",
        "release_date": "1978-12-13",
        "original_language": "en",
        "original_title": "Superman",
        "genre_ids": [28, 12, 14, 878],
        "backdrop_path": "/l4BuWj6RT9fG1idYkj6kTNtP50E.jpg",
        "adult": false,
        "overview":
            "　　话说克利顿星球爆炸之前，超人父母将婴儿放入火箭中送到地球，他被一对农家夫妇收养，长大成为记者。当美国遭野心家企图毁灭时，他就跑进电话亭中穿上S型超人制服，变成挽救各种危机的超人。",
        "poster_path": "${IMAGE_URL_MEDIUM}/n2DOECThGG7h7m5AjLi2Nuh23u1.jpg",
        "popularity": 22.52
      },
      {
        "adult": false,
        "backdrop_path": "/1d0bPDy0Ud7g7vZ5qnKI6HsduLE.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 8536,
        "original_language": "en",
        "original_title": "Superman II",
        "overview":
            "　　三名被囚禁在外层空间的克利顿星球大坏蛋逃了出来，来到地球上的一个小镇扬威肆虐。当时超人正与女友在冰宫卿卿我我，并且已经丧失了超人的全部本领而变成了平凡人。在这种不利的情况下，美国总统不得不向这三个大坏蛋求饶。后来超人振作起来，与三个坏蛋展开了殊死搏斗，最终战胜了三个大坏蛋。本片在特技效果上维持水准之外，导演理查德．莱斯特在这部续集加强了超人的人性描写，喜剧效果也较强，部分情节颇具讽刺效果。",
        "poster_path": "${IMAGE_URL_MEDIUM}/upHCNXVFTztai9ywfgV3LEdj1he.jpg",
        "release_date": "1980-12-04",
        "title": "超人2",
        "video": false,
        "vote_average": 6.6,
        "vote_count": 915,
        "popularity": 21.907
      },
      {
        "adult": false,
        "backdrop_path": "/nmV9MdbzST4xv8WMHwhVgxkHHjM.jpg",
        "genre_ids": [28, 12, 35, 878],
        "id": 287947,
        "original_language": "en",
        "original_title": "Shazam!",
        "overview": "",
        "poster_path": "${IMAGE_URL_MEDIUM}/gGfsj3VW3qAtCdFjs7qa5fHc8aD.jpg",
        "release_date": "2019-04-03",
        "title": "Shazam!",
        "video": false,
        "vote_average": 0,
        "vote_count": 5,
        "popularity": 15.602
      },
      {
        "adult": false,
        "backdrop_path": "/pkqkxX7tkN0QLBtOYzugtBqyu0C.jpg",
        "genre_ids": [28, 12, 35, 14, 878],
        "id": 9531,
        "original_language": "en",
        "original_title": "Superman III",
        "overview":
            "　　超人又回来了！这次，超人克拉克（克里斯托弗•里夫 Christopher Reeve 饰）回家乡去参加高中同学聚会。聚会上，克拉克重遇了以前就一直心仪的女孩拉娜（安妮特•奥图勒 Annette O'Toole 饰）。爱火重燃的克拉克对拉娜展开了爱情攻势，两人很快就堕入了情网。正当两人浓情蜜意时，发生了一场灾难。本应马上出动的克拉克因为沉浸在和拉娜共处的时光而延误了救灾，导致了更多无辜的人们的伤亡，为此克拉克感到异常的自责。　　同时，野心勃勃的巨富利用气象卫星技术控制着世界各地的气候以此牟利，造成了很多地方天灾连连。他心知超人一定会来找自己的麻烦，于是不惜重金又制造出了一个超级电脑机器人用来对付超人。克拉克这次能否最终战胜邪恶？",
        "poster_path": "${IMAGE_URL_MEDIUM}/qJ73cyIZE8z4rLwa8mL3ZI85U3e.jpg",
        "release_date": "1983-06-17",
        "title": "超人3",
        "video": false,
        "vote_average": 5.3,
        "vote_count": 685,
        "popularity": 11.374
      },
      {
        "adult": false,
        "backdrop_path": "/amXWhCkrsN7p9S6rnLCgD9fNwE6.jpg",
        "genre_ids": [28, 16, 878, 10751],
        "id": 13640,
        "original_language": "en",
        "original_title": "Superman: Doomsday",
        "overview": "",
        "poster_path": "${IMAGE_URL_MEDIUM}/3of4nShmv1hBmrebOQqGlfZ9ZL0.jpg",
        "release_date": "2007-09-18",
        "title": "超人之死",
        "video": false,
        "vote_average": 6.6,
        "vote_count": 201,
        "popularity": 8.815
      },
      {
        "adult": false,
        "backdrop_path": "/hqkIcbrOHL86UncnHIsHVcVmzue.jpg",
        "genre_ids": [28, 80, 18, 53],
        "id": 155,
        "original_language": "en",
        "original_title": "The Dark Knight",
        "overview":
            "从亲眼目睹父母被杀的阴影中走出来的蝙蝠侠布鲁斯·韦恩（克里斯蒂安·贝尔 Christian Bale 饰），在戈登警长（加里·奥德曼 Gary Oldman 饰）和检察官哈维（艾伦·艾克哈特 Aaron Eckhart 饰）的帮助下，无后顾之忧地满世界奔波，与罪犯们做着永无休止的争斗，高谭市的犯罪率也以惊人的速度持续下降。但在高谭这个科技与污秽并存的城市，平静不可能维持得太久，很快新一轮的混乱就席卷了整个城市，人们再度被恐慌笼罩，而这一切混乱的源头正是小丑（希斯·莱杰 Heath Ledger 饰）。",
        "poster_path": "${IMAGE_URL_MEDIUM}/1hRoyzDtpgMU7Dz4JF22RANzQO7.jpg",
        "release_date": "2008-07-16",
        "title": "蝙蝠侠：黑暗骑士",
        "video": false,
        "vote_average": 8.4,
        "vote_count": 16112,
        "popularity": 38.805
      },
      {
        "adult": false,
        "backdrop_path": "/65JWXDCAfwHhJKnDwRnEgVB411X.jpg",
        "genre_ids": [28, 80, 18],
        "id": 272,
        "original_language": "en",
        "original_title": "Batman Begins",
        "overview":
            "布鲁斯·韦恩（克里斯汀·贝尔饰）童年亲眼目睹了父母在高谭市街头被歹徒枪杀，韦恩充满怒火。在继承了父亲亿万家产后，韦恩开始环游世界，希望凭自己的力量复仇和打击犯罪。韦恩为了了解罪犯的心理，在亚洲亲自体验了犯罪的感觉，最后被捕入狱。他在狱中遇到了神秘组织影武者联盟的代言人，他指引韦恩寻找到了影武者联盟并传授韦恩高强的武艺和坚韧的意志力。后因得知影武者联盟要摧毁自己的家乡高谭市，而毁掉了联盟的基地并回到故乡。随后韦恩在管家阿福（迈克尔·凯恩饰）和韦恩企业工程师福克斯（摩根·弗里曼饰）的协助下化身蝙蝠侠开始了在高谭市打击犯罪、维护正义的道路……",
        "poster_path": "${IMAGE_URL_MEDIUM}/95V5GZOKBWZPeDY6IBlo1jh1Uu9.jpg",
        "release_date": "2005-06-10",
        "title": "蝙蝠侠：侠影之谜",
        "video": false,
        "vote_average": 7.6,
        "vote_count": 10311,
        "popularity": 38.884
      },
      {
        "adult": false,
        "backdrop_path": "/jYLh4mdOqkt30i7LTFs3o02UcGF.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 49521,
        "original_language": "en",
        "original_title": "Man of Steel",
        "overview":
            "克拉克·肯特（Clark Kent/Kal-El ）是一个20来岁的年轻记者，他拥有超出别人想像的能力，因为他是从比地球文明更高级的外星来到地球的。克拉克为“我为什么到这里”而感到困惑纠结，他的地球养父母帮助他形成了人生价值观。很快克拉克就意识到，拥有超能力就意味着要作出特别艰难的决定——当世界受到威胁、特别需要稳定的时候，他的能力是用来维护和平还是分化和征服呢？克拉克必须成为“超人”，不仅作为这个世界最后的希望灯塔照耀全人类，也要保护他所热爱的一切",
        "poster_path": "${IMAGE_URL_MEDIUM}/xWlaTLnD8NJMTT9PGOD9z5re1SL.jpg",
        "release_date": "2013-06-12",
        "title": "超人：钢铁之躯",
        "video": false,
        "vote_average": 6.5,
        "vote_count": 8463,
        "popularity": 43.818
      },
      {
        "adult": false,
        "backdrop_path": "/1MbLKqHXBw2NJsd5Q2OvtO8qUZV.jpg",
        "genre_ids": [28, 12, 878],
        "id": 299537,
        "original_language": "en",
        "original_title": "Captain Marvel",
        "overview": "",
        "poster_path": "${IMAGE_URL_MEDIUM}/2ClU44E07dC6tPYhxJA8hbWDUAQ.jpg",
        "release_date": "2019-03-06",
        "title": "Captain Marvel",
        "video": false,
        "vote_average": 0,
        "vote_count": 4,
        "popularity": 21.209
      },
      {
        "id": 283995,
        "video": false,
        "vote_count": 9552,
        "vote_average": 7.7,
        "title": "银河护卫队2",
        "release_date": "2017-04-19",
        "original_language": "en",
        "original_title": "Guardians of the Galaxy Vol. 2",
        "genre_ids": [28, 12, 35, 878],
        "backdrop_path": "/aJn9XeesqsrSLKcHfHP4u5985hn.jpg",
        "adult": false,
        "overview":
            "火箭浣熊（布莱德利·库珀 Bradley Cooper 饰）偷走了大祭司阿耶莎（伊丽莎白·德比齐 Elizabeth Debicki 饰）的能量电池，包括星爵（克里斯·帕拉特 Chris Pratt 饰）、卡魔拉（佐伊·索尔达娜 Zoe Saldana 饰）、德拉克斯（戴夫·巴蒂斯塔 Dave Bautista 饰）在内的一行人遭到了后者派出的舰队的袭击。一个神秘人物乘坐着飞船救下了银河护卫队的众人，而驾驶着飞船的不是别人，竟然正是星爵的亲生父亲伊戈（库尔特·拉塞尔 Kurt Russell 饰）。 在伊戈的带领下，星爵、卡魔拉和德拉克斯来到了由伊戈一手制造的星球上，而剩下的成员们则着手修复损坏的飞船。那边厢，阿耶莎委托勇度（迈克尔·鲁克 Michael Rooker 饰）抓住星爵替自己报仇，而卡魔拉亦渐渐发现了伊戈和善面目下隐藏的巨大阴谋。",
        "poster_path": "/ajjbmuCciJi9PJFeAVkL0LpHqX.jpg",
        "popularity": 47.372
      },
      {
        "adult": false,
        "backdrop_path": "/tFI8VLMgSTTU38i8TIsklfqS9Nl.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 284052,
        "original_language": "en",
        "original_title": "Doctor Strange",
        "overview":
            "“奇异博士”斯特兰奇是漫威第三阶段的重要角色，曾经是一位外科医生的他在车祸之后失去了赖以为生的本领，为了治疗双手，斯特兰奇踏上前往异国他乡的旅程，旅途中的奇遇让他成为了拥有超凡魔力的至尊法师，并运用自己的本领对抗黑暗力量，捍卫世界。",
        "poster_path": "${IMAGE_URL_MEDIUM}/cyyTjHW0oemFgJYE7Gyx5yxbFbs.jpg",
        "release_date": "2016-10-25",
        "title": "奇异博士",
        "video": false,
        "vote_average": 7.3,
        "vote_count": 9787,
        "popularity": 46.58
      },
      {
        "adult": false,
        "backdrop_path": "/tx1MSh4Ww6jmqJF2JD2p7K53hWZ.jpg",
        "genre_ids": [28, 12, 878],
        "id": 299534,
        "original_language": "en",
        "original_title": "Untitled Avengers Movie",
        "overview": "",
        "poster_path": "${IMAGE_URL_MEDIUM}/guViKKIY0D5UlfQcHnusB8zrJqc.jpg",
        "release_date": "2019-04-24",
        "title": "复仇者联盟3：无限战争(下)",
        "video": false,
        "vote_average": 0,
        "vote_count": 9,
        "popularity": 22.873
      },
      {
        "adult": false,
        "backdrop_path": "/6iUNJZymJBMXXriQyFZfLAKnjO6.jpg",
        "genre_ids": [28, 12, 14, 10752],
        "id": 297762,
        "original_language": "en",
        "original_title": "Wonder Woman",
        "overview":
            "戴安娜是亚马逊一族的公主，生活在天堂岛上。天堂岛是一个纯女人的国度，居民们都长生不老、头脑聪明，且拥有着巨大神力。因为一起意外事件，戴安娜离开家乡，来到了钢筋水泥的城市里，从此作为天堂岛的使者保护人类……",
        "poster_path": "${IMAGE_URL_MEDIUM}/1bmocxZAGEU8Gr7jKBsZplrsi9d.jpg",
        "release_date": "2017-05-30",
        "title": "神奇女侠",
        "video": false,
        "vote_average": 7.2,
        "vote_count": 10128,
        "popularity": 48.652
      },
      {
        "adult": false,
        "backdrop_path": "/vsjBeMPZtyB7yNsYY56XYxifaQZ.jpg",
        "genre_ids": [28, 12, 14],
        "id": 209112,
        "original_language": "en",
        "original_title": "Batman v Superman: Dawn of Justice",
        "overview":
            "　　故事发生在大都会之战18个月后，在那场战斗中许多建筑和市民惨遭波及，许多人把具有超凡力量的氪星人当作凡间之神来膜拜，身处险境的时候会祈求他的救助。但同时超人（亨利·卡维尔 Henry Cavill 饰）也因与佐德之战对城市造成的破坏而遭到逮捕和审讯，一度成为都市传说的蝙 蝠侠（本·阿弗莱克 Ben Affleck 饰）重新出现在人们面前，他似乎正是为了惩罚超人而来。年轻的富豪莱克斯·卢瑟（杰西·艾森伯格 Jesse Eisenberg 饰）又在二者的矛盾中挑拨离间，神秘的戴安娜·普林斯（盖尔·加朵 Gal Gadot 饰）也因为自己的目的而介入其中……",
        "poster_path": "${IMAGE_URL_MEDIUM}/j3eNuyIxsNbo0l29DhUh2QpKR9G.jpg",
        "release_date": "2016-03-23",
        "title": "蝙蝠侠大战超人：正义黎明",
        "video": false,
        "vote_average": 5.8,
        "vote_count": 10242,
        "popularity": 49.855
      },
      {
        "adult": false,
        "backdrop_path": "/o5T8rZxoWSBMYwjsUFUqTt6uMQB.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 141052,
        "original_language": "en",
        "original_title": "Justice League",
        "overview":
            "受到超人无私奉献的影响，蝙蝠侠重燃了对人类的信心，接受了新盟友——神奇女侠（戴安娜·普林斯）的帮助，去对抗更加强大的敌人。蝙蝠侠和神奇女侠一同寻找并招募了一支超人类联盟来抵挡新觉醒的威胁。但尽管这支队伍集结了超人、蝙蝠侠、神奇女侠、闪电侠、海王和钢骨等人，他们似乎无法阻止敌人对地球的进攻……",
        "poster_path": "${IMAGE_URL_MEDIUM}/bXtGfAKXg9oXV83aIKtkVBtAmRb.jpg",
        "release_date": "2017-11-15",
        "title": "正义联盟",
        "video": false,
        "vote_average": 6.3,
        "vote_count": 5632,
        "popularity": 60.131
      },
      {
        "adult": false,
        "backdrop_path": "/kqmt4fOCNZPOVwjiG8q93oaH70X.jpg",
        "genre_ids": [28, 12, 14, 878],
        "id": 9651,
        "original_language": "en",
        "original_title": "Supergirl",
        "overview":
            "为了寻找失落于地球的量天仪宝珠，太空城族长扎尔塔（彼德·奥图 Peter O'Toole 饰）派遣女超人卡拉（海伦·斯雷特 Helen Slater 饰）前往地球。此时的宝珠落到了邪恶的女巫赛琳娜（费·唐纳薇 Faye Dunaway 饰）的手中，为了炫耀这价值连城的宝 物，赛琳娜举办了一场晚会，而这就是卡拉夺回宝物的最佳时机。卡拉的举动惹恼了赛琳娜，她设计将卡拉骗至恐怖城，夺走了她的力量与自由。 得知卡拉遇险，扎尔塔前来营救，却不想命丧赛琳娜之手。悲愤的卡拉想方设法逃脱了赛琳娜的桎梏，为了给死去的扎尔塔报仇，为了夺回珠宝，为了维护世界的和平，卡拉做好了准备，要与赛琳娜展殊死搏斗。",
        "poster_path": "${IMAGE_URL_MEDIUM}/d1aLbq1pU3NQyJehHnwx3NlOTOq.jpg",
        "release_date": "1984-11-19",
        "title": "女超人",
        "video": false,
        "vote_average": 4.7,
        "vote_count": 153,
        "popularity": 15.284
      },
      {
        "adult": false,
        "backdrop_path": "/iYrE2zV1DfZ3l7Lh4frHzNwFncq.jpg",
        "genre_ids": [28, 16, 80, 18],
        "id": 382322,
        "original_language": "en",
        "original_title": "Batman: The Killing Joke",
        "overview":
            "他是蝙蝠侠最不共戴天的宿敌，是丧心病狂的犯罪大师，他怪异的狂暴行径就连世界最佳侦探也琢磨不透。然而小丑并非天生如此。在他成为犯罪界的小丑王子之前，在那命定的一天将他面容尽毁、心灵永久扭曲之前，他也曾是黑暗骑士愿意献出生命去保护的对象——一个平凡人 。  　　是什么导致了这个平凡公民堕落成了哥谭有史以来最强反派？蝙蝠侠能阻止小丑把戈登局长和他的女儿芭芭拉拖入疯狂深渊的计划吗？这对死敌能及时为他们之间无尽的对决画下一个句号吗？",
        "poster_path": "/cJ8ujdAx1FG6HWGiaaXxN7OYrjA.jpg",
        "release_date": "2016-07-21",
        "title": "蝙蝠侠：致命玩笑",
        "video": false,
        "vote_average": 6.2,
        "vote_count": 710,
        "popularity": 15.067
      },
      {
        "adult": false,
        "backdrop_path": "/rOWMgSlj69fUjYjMVfkvL62mfz7.jpg",
        "genre_ids": [28, 16],
        "id": 379291,
        "original_language": "en",
        "original_title": "Justice League vs. Teen Titans",
        "overview":
            "《正义联盟大战少年泰坦》（Justice League vs. Teen Titans）由萨姆·刘执导，斯图尔特·艾伦、泰莎·法梅加、布兰登·司徒、谢默·摩尔、凯瑞·华格伦等配音，讲述少年泰坦面对危机，拯救世界的故事。",
        "poster_path": "/dQMO9EJxDBkdRzWUEWkbYzrMDC0.jpg",
        "release_date": "2016-03-29",
        "title": "正义联盟大战少年泰坦",
        "video": false,
        "vote_average": 6.9,
        "vote_count": 288,
        "popularity": 14.741
      },
      {
        "id": 30061,
        "video": false,
        "vote_count": 230,
        "vote_average": 7.1,
        "title": "正义联盟：两个地球的危机",
        "release_date": "2010-02-23",
        "original_language": "en",
        "original_title": "Justice League: Crisis on Two Earths",
        "genre_ids": [28, 12, 16],
        "backdrop_path": "/m8pvzH17KRA4ChPjDDkU781oN8W.jpg",
        "adult": false,
        "overview": "",
        "poster_path": "/mImQPVPKNGlqPDmewsZ7TLvHND.jpg",
        "popularity": 13.937
      }
    ].map((item) => Media.fromJson(item)).toList();
