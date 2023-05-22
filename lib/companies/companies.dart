// ignore_for_file: prefer_const_constructors, void_checks

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../shared/components/components.dart';
import '../shared/style/icon_broken.dart';

class Companies {
  late String phone;
  late String web;
  late String emaile;
  late String location;
  late String locationLink;
  late String title;
  Companies({
    required this.web,
    required this.phone,
    required this.emaile,
    required this.location,
    required this.locationLink,
    required this.title,
  });
}

class CompaniesScreen extends StatefulWidget {
  const CompaniesScreen({super.key});

  @override
  State<CompaniesScreen> createState() => _CompaniesScreenState();
}

// ignore: camel_case_types
class _CompaniesScreenState extends State<CompaniesScreen> {
  var boardControlle = PageController();
  bool isLast = false;
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

  List<Companies> companies = [
    Companies(
        web: 'www.jett.com.jo',
        phone: '00965854679',
        emaile: 'info@jtt.com.jo',
        location: 'Seventh Circle',
        title: 'Jet company',
        locationLink: 'https://goo.gl/maps/XtTFci7twogWHxWW6'),
    Companies(
        web: 'www.alpha-jo.com',
        phone: '0096265850430',
        emaile: 'info@alpha-jo.com',
        location: 'Industry Street',
        title: 'Alfa bus rental company',
        locationLink: 'https://goo.gl/maps/gHYyK5xotAoMQTXu5'),
    Companies(
        web: 'www.rumtrans.com',
        phone: '0096264290667',
        emaile: 'info@rumtrans.com',
        location: 'Mother of the orchards',
        title: 'Rum Tourist Transport',
        locationLink: 'https://maps.app.goo.gl/Q7NQh7wX5oNntBEk6'),
    Companies(
        web: 'www.mesktransport.com',
        phone: '0096264396555',
        emaile: 'Eminfo@mesktransport.com',
        location: 'alyasamin',
        title: 'Misk for specialized tourist transportation',
        locationLink: 'https://goo.gl/maps/phzXGF9wEva67Z4t6'),
    Companies(
        web: 'www.smartway.com.jo',
        phone: '00962797600206',
        emaile: 'info@smartway.com.jo',
        location: 'aljabiha',
        title: 'Smart Way Tourist Transportation Company',
        locationLink: 'https://goo.gl/maps/fa7AmGNVFaofV7xp8'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
          title: Text(
            'See Jordan',
            style: GoogleFonts.abrilFatface()
                .copyWith(fontSize: 25, color: Colors.black),
          ),
          actions: const [
            Icon(
              IconBroken.search,
              color: Colors.black,
            ),
            SizedBox(
              width: 10,
            ),
            Icon(
              IconBroken.notification,
              color: Colors.black,
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Card(
                elevation: 7,
                child: Container(
                  color: Color.fromARGB(255, 75, 74, 74),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Some companies provide buses and organized tours in modern, air-conditioned vehicles. For schedules and times, please inquire with the hotel guest services officer or visit the destination pages available on the website.',
                      style:TextStyle(
                        fontSize: 17,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildCared(
                    companies[index], () => openUrl(web: companies[index].web)),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20,
                ),
                itemCount: companies.length,
              ),
            ],
          ),
        ));
  }

  Widget buildCared(Companies model, Function()? url) {
    return Card(
      elevation: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color:Color.fromARGB(255, 75, 74, 74),
            width: double.infinity,
           
            child: Padding(
              padding: const EdgeInsets.all( 10.0, ),
              child: Text(
                model.title,
                style: GoogleFonts.abrilFatface().copyWith(
                  fontSize: 20,color: Colors.white
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            // ignore: deprecated_member_use
            onTap: () => launch('tel://${model.phone}'),
            child: deffaultListTitle(
                icon: IconBroken.calling,
                title: model.phone,
                colorText: Colors.black,
                colorIcon: Colors.amber),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            // ignore: deprecated_member_use
            onTap: () => launch('mailto:${model.emaile}'),
            child: deffaultListTitle(
                icon: IconBroken.message,
                title: model.emaile,
                colorText: Colors.black,
                colorIcon: Colors.amber),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              var nativeUrl = "https://${model.web}";
              var webUrl = "https://${model.web}";

              try {
                await launchUrlString(nativeUrl,
                    mode: LaunchMode.externalApplication);
              } catch (e) {
                print(e);
                await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
              }
            },
            child: deffaultListTitle(
                icon: IconBroken.paperNegative,
                title: model.web,
                colorText: Colors.black,
                colorIcon: Colors.amber),
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () async {
              print(model.location);
              var nativeUrl = "${model.locationLink}";
              var webUrl = "${model.locationLink}";

              try {
                await launchUrlString(nativeUrl,
                    mode: LaunchMode.externalApplication);
              } catch (e) {
                print(e);
                await launchUrlString(webUrl, mode: LaunchMode.platformDefault);
              }
            },
            child: deffaultListTitle(
                icon: IconBroken.location,
                title: model.location,
                colorText: Colors.black,
                colorIcon: Colors.amber),
          ),
          SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
