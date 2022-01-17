// @dart=2.9
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About EMDC"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Image(
                    image: NetworkImage(
                        'https://pbs.twimg.com/profile_images/803283609260003329/bAg76QPv_400x400.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Text(
              "Entrepreneurship & Management Development Centre (EMDC) is functioning in the college with the intention of nurturing entrepreneurship skills of the students. The cell provides a platform for the students to pursue entrepreneurial activities and also provide assistance to potential entrepreneurs. With the prime goal of developing responsible innovators out of engineers, the EMDC strives to assist every aspiring entrepreneur on every single step.",
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }
}
