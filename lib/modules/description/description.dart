// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/components/components.dart';
import 'package:flutter_application_1/shared/style/icon_broken.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DescriptionScreen extends StatelessWidget {
  const DescriptionScreen(
      {super.key,
      required this.image,
      required this.decs,
      required this.title,
      required this.location,
      required this.url});
  final String image;
  final String decs;
  final String title;
  final String location;
  final String url;
  Future<void> openUrl({
    required String web,
  }) async {
    var nativeUrl = "${web}";
    var webUrl = "${web}";

    try {
      await launchUrlString(nativeUrl, mode: LaunchMode.externalApplication);
    } catch (e) {
      print(e);
      await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: deffaultAppBar(
        context: context,
        title: Text(
          'Description',
          style: GoogleFonts.abyssinicaSil(
              fontWeight: FontWeight.bold, height: 1.1, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                image: DecorationImage(
                    image: NetworkImage('$image'), fit: BoxFit.fill),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 10, top: 10),
              child: Text(
                '$title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Icon(
                    IconBroken.location,
                    color: Colors.amber,
                  ),
                  Text(
                    '$location',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Spacer(),
                  Icon(
                    IconBroken.heart,
                    color: Colors.red,
                    size: 20,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(style: Theme.of(context).textTheme.bodyMedium, '$decs'),
            SizedBox(
              height: 20,
            ),
            // Row(
            //   children: [
            //     Icon(
            //       Icons.map,
            //       color: Colors.black,
            //       size: 20,
            //     ),
            //     Center(
            //       child: Link(
            //         target: LinkTarget.blank,
            //         uri: Uri.parse('$url'),
            //         builder: (BuildContext context,
            //                 Future<void> Function()? followLink) =>
            //             TextButton(
            //           onPressed: followLink,
            //           child: Text(
            //             'Location in Map',
            //             style: TextStyle(color: Colors.black),
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Icon(
                  Icons.map_outlined,
                  color: Colors.amber,
                ),
                GestureDetector(
                    onTap: () async {
                      print('$url');
                      var nativeUrl = "$url";
                      var webUrl = "$url";

                      try {
                        await launchUrlString(nativeUrl,
                            mode: LaunchMode.externalApplication);
                      } catch (e) {
                        print(e);
                        await launchUrlString(webUrl,
                            mode: LaunchMode.platformDefault);
                      }
                    },
                    child: Text(
                      'Location in Map',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
