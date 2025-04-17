import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ten_x_app/patient/patientExplore/patient_explore.dart';
import '../../common/colors/colors.dart';
import '../../common/commonText/common_text.dart';
import '../../controller/appstream_controller.dart';
import '../../controller/bottom_controller.dart';
import '../patientBooking/patient_bookings.dart';
import '../patientChat/patientChat.dart';
import 'patient_home.dart';
import '../patientServices/patient_services.dart';


int isAlreadySelected = 0;
final ValueNotifier<int> counter = ValueNotifier<int>(0);
class PatientDashboard extends StatefulWidget {
  const PatientDashboard({super.key});

  @override
  State<PatientDashboard> createState() => _PatientDashboardState();
}

class _PatientDashboardState extends State<PatientDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  AppStreamController appStreamController = AppStreamController.instance;
  bool showBottomBar = true;


  initStreamListener() {
    appStreamController.handleBottomTabAction.listen((event) {
      print("under bottom nav stream event $event");
      if (event != null) {
        showBottomBar = event;
      }
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initStreamListener();
    pages = [
      PatientHome(),
      Patientchat(),
      PatientExplore(),
      PatientServices(),
      PatientBookings(),
    ];
  }

  int indexBack = 0;
  List<Widget>? pages = [];
  final List<GlobalKey<NavigatorState>> states = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  List<Widget> getNavigators() {
    List<Widget> widgets = [];
    for (int i = 0; i < pages!.length; i++) {
      widgets.add(Navigator(
        key: states[i],
        onGenerateRoute: (settings) =>
            MaterialPageRoute(
              settings: settings,
              builder: (context) => pages![i],
            ),
      ));
    }
    return widgets;
  }

  final bottomBarController = Get.put(BottomBarController());


  Widget buildMyNavBar(context, value) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Obx(() =>
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, "assets/svgIcon/homeIcon.svg", "Home"),
              _buildNavItem(1, "assets/svgIcon/chatIcon.svg", "Chat"),
              // _buildNavItem(2, "assets/svgIcon/exploreIcon.svg", "Explore"),
              Container(
                margin: EdgeInsets.only(top: 12),
                child: Column(
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            //_currentIndex = 2;
                            bottomBarController.selectedIndex.value = 2;
                            onTapNav(2);
                          });
                        },
                        child: SvgPicture.asset("assets/svgIcon/exploreIcon.svg"),
                      ),
                    ),
                    SizedBox(height: 4,),
                    CommonText(
                      text: 'Explore',
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w200,
                    ),
                  ],
                ),
              ),
              _buildNavItem(3, "assets/svgIcon/servicesIcon.svg", "Services"),
              _buildNavItem(4, "assets/svgIcon/bookingsIcon.svg", "Bookings"),
            ],
          )),
    );
  }

  Widget _buildNavItem(int index, String iconPath, String label) {
    bool isSelected = bottomBarController.selectedIndex.value == index;
    return GestureDetector(
      onTap: () {
        bottomBarController.selectedIndex.value = index;
        onTapNav(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            colorFilter: ColorFilter.mode(
              isSelected ? AppColors.redOrange : Colors.black,
              BlendMode.srcIn,
            ),
            height: 24,
            width: 24,
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              //color: isSelected ? AppColors.redOrange : Colors.black,
              fontSize: 12,
            ),
          ),
          if (isSelected) // Only show dot for selected item
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.redOrange,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }


  onTapNav(int index) async {
    setState(() {
      bottomBarController.selectedIndex.value = index;
    });
    if (index == 1) {
      isAlreadySelected = 0;
    }
    print('index==>>$index');
    print("fxgdfhf∂==>>$isAlreadySelected");
    print("fxgdfhf∂==>>$bottomBarController.selectedIndex.value");
    if (index == 0) {
      states[bottomBarController.selectedIndex.value].currentState!.popUntil((
          route) => route.isFirst);
      isAlreadySelected++;
      setState(() {});
      print("isAlreadySelected==>>$isAlreadySelected");

      if (isAlreadySelected == 0) {
        print("Xcgcgh==>>$isAlreadySelected");
      } else if (isAlreadySelected == 1) {
        print("dgdsg==>$isAlreadySelected");
        WidgetsBinding.instance.addPostFrameCallback((_) async {

        });
        bottomBarController.selectedIndex.value = 0;
        setState(() {});
      }
    } else if (index == 2) {
      appStreamController.rebuildHandleBottomTabStream();
      appStreamController.handleBottomTab.add(true);
      isAlreadySelected = 0;
      print("Index 2 is Called");
      //showModelBottomSheet(context, index);
    } else if (index == 3) {
      print("dfgxbgchffgf");
    } else if (index == 4) {
      states[bottomBarController.selectedIndex.value].currentState!.popUntil((
          route) => route.isFirst);
      isAlreadySelected = 0;
      print("dfgxbgchffgf");
    }
    print('tab clicked');
  }

  //int _selectedIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      if (index == bottomBarController.selectedIndex.value) {
        states[bottomBarController.selectedIndex.value].currentState!.popUntil((
            route) => route.isFirst);
      } else {
        bottomBarController.selectedIndex.value = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (states[bottomBarController.selectedIndex.value].currentState!
              .canPop()) {
            return !await states[bottomBarController.selectedIndex.value]
                .currentState!.maybePop();
          } else {
            if (bottomBarController.selectedIndex.value != 0) {
              onTabTapped(0);
              return false;
            } else {
              return true;
            }
          }
        },
        child: Scaffold(
          key: _scaffoldKey,
          body: Obx(() =>
              IndexedStack(
                index: bottomBarController.selectedIndex.value,
                children: getNavigators(),
              )),
          bottomNavigationBar: !showBottomBar
              ? const SizedBox()
              : ValueListenableBuilder(valueListenable: counter,
              builder: (BuildContext context, int value, Widget? child) {
                return buildMyNavBar(context, value);
              }),
          //bottomNavigationBar: _buildBottomNavigationBar()

        )
    );
  }
}