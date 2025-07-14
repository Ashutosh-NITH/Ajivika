import 'package:ajivika/contractorsection/Homepage/AddJob.dart';
import 'package:ajivika/contractorsection/Homepage/ViewDetails.dart';
import 'package:ajivika/contractorsection/contractor_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../../languagepage/language_page.dart';

class ContractorHomepage extends StatefulWidget {
  @override
  State<ContractorHomepage> createState() => _ContractorHomepageState();
}

// List<Map<String, dynamic>> _alljobmarkers = [];

class _ContractorHomepageState extends State<ContractorHomepage> {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    super.initState();
    setupmap();
  }

  String? MapboxAccessToken;

  void setupmap() async {
    await dotenv.load(fileName: '.env');
    MapboxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;
    MapboxOptions.setAccessToken(MapboxAccessToken!);
    context.read<ContractorHomepageProvider>().getinitialjobs();
  }

  double currlat = 25.61;

  double currlong = 85.15;
  MapboxMap? _mapboxController;
  PointAnnotationManager? _annotationManager;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // appbar
          Container(color: Colors.white, height: 50),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // left part => help
                InkWell(
                  onTap: () {
                    // perform action => get help => customer care
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 20),
                      FaIcon(
                        FontAwesomeIcons.headset,
                        color: Color(0xff2667FF),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "help".tr,
                        style: TextStyle(color: Color(0xff2667FF)),
                      ),
                    ],
                  ),
                ),
                // right part => voice and language
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // perform action => speak on tap of audio icon
                      },
                      child: FaIcon(
                        FontAwesomeIcons.volumeHigh,
                        color: Color(0xff2667FF),
                      ),
                    ),
                    SizedBox(width: 25),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          (context),
                          MaterialPageRoute(
                            builder: (context) => language_page(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "language".tr,
                            style: TextStyle(color: Color(0xff2667FF)),
                          ),
                          SizedBox(width: 5),
                          FaIcon(
                            FontAwesomeIcons.angleDown,
                            color: Color(0xff2667FF),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ],
            ),
          ),
          Container(height: 20, color: Colors.white),

          //mapbox map
          Expanded(
            child: MapWidget(
              onMapCreated: (controller) async {
                _mapboxController = controller;
                await _mapboxController?.setCamera(
                  CameraOptions(
                    center: Point(coordinates: Position(currlong, currlat)),
                    zoom: 10,
                  ),
                );
                await _mapboxController?.gestures.updateSettings(
                  GesturesSettings(
                    scrollEnabled: true,
                    scrollMode: ScrollMode.HORIZONTAL_AND_VERTICAL,
                    rotateEnabled: true,
                    pitchEnabled: true,
                    simultaneousRotateAndPinchToZoomEnabled: true,
                    pinchToZoomEnabled: true,
                    doubleTapToZoomInEnabled: true,
                    doubleTouchToZoomOutEnabled: true,
                    pinchPanEnabled: true,
                    quickZoomEnabled: true,
                  ),
                );
                _annotationManager = await _mapboxController?.annotations
                    .createPointAnnotationManager();
                final ByteData bytedata = await rootBundle.load(
                  "assets/images/placeholder.png",
                );
                final Uint8List pinimage = bytedata.buffer.asUint8List();
                for (var job
                    in context
                        .read<ContractorHomepageProvider>()
                        .alljobmarkers) {
                  print(job);
                  var point = Point(
                    coordinates: Position(job['long'], job['lat']),
                  );
                  var option = PointAnnotationOptions(
                    geometry: point,
                    image: pinimage,
                    iconSize: 0.15,
                    textField: "${job['nol']}",
                    textColor: 0xffCAE00D,
                    textSize: 14,
                  );
                  final annotation = await _annotationManager?.create(option);
                  if (annotation != null) {
                    context
                        .read<ContractorHomepageProvider>()
                        .annotaionMetadata["${annotation.id}"] = {
                      'id': job['id'],
                      'wage': job['wage'],
                      'nol': job['nol'],
                      'desc': job['desc'],
                      'lat': job['lat'],
                      'long': job['long'],
                      'dateposted': job['date_posted'],
                    };
                  }
                }
                _annotationManager?.addOnPointAnnotationClickListener(
                  MyAnnotationClickListener(
                    onTap: (annotation) {
                      final Map<String, dynamic> detail = context
                          .read<ContractorHomepageProvider>()
                          .annotaionMetadata["${annotation.id}"]!;
                      Navigator.push(
                        (context),
                        MaterialPageRoute(
                          builder: (context) => ViewDetails(detail: detail),
                        ),
                      );
                      // do something
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Navigator.push(
            (context),
            MaterialPageRoute(
              builder: (context) =>
                  AddJob(MapboxAccessToken: MapboxAccessToken!),
            ),
          );
          await context.watch<ContractorHomepageProvider>().getAlljobs()
              ? setState(() {})
              : print("no changes");
        },
        label: Text("Post job"),
        icon: Icon(Icons.add_circle),
      ),
    );
  }
}

// advanced (didnt understand )
class MyAnnotationClickListener extends OnPointAnnotationClickListener {
  final void Function(PointAnnotation annotation) onTap;

  MyAnnotationClickListener({required this.onTap});

  @override
  bool onPointAnnotationClick(PointAnnotation annotation) {
    onTap(annotation);
    return true; // Consume the event
  }
}
