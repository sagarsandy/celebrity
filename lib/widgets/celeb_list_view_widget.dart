import 'package:cached_network_image/cached_network_image.dart';
import 'package:celebrity/models/celebrity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CelebListViewWidget extends StatelessWidget {
  final List<Celebrity> celebrities;

  CelebListViewWidget({this.celebrities});

  // Get celebrity image
  String getImageUrl({String celebId = "8914"}) {
    final String imageUrl =
        "https://celebritybucks.com/images/celebs/mid/" + celebId + ".jpg";
    return imageUrl;
  }

  // Get celebrity DOB
  String getDateOfBirth({String celebDate}) {
    DateFormat dateFormat = DateFormat('yyyy-mmm-dd');
    DateTime date = dateFormat.parse(celebDate);

    return DateFormat.yMMMd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: celebrities.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        ClipOval(
                          child: Container(
                            width: 70,
                            height: 70,
                            child: CachedNetworkImage(
                              imageUrl: getImageUrl(
                                  celebId: celebrities[index].celebId),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 90,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                celebrities[index].name,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(getDateOfBirth(
                                      celebDate: celebrities[index].dob) +
                                  "        " +
                                  celebrities[index].age.toString() +
                                  " Year"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
