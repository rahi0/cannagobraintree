//import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:canna_go_dev/redux/state.dart';
import 'package:canna_go_dev/redux/reducer.dart';
import 'package:canna_go_dev/screen/loginPage/loginPage.dart';
import 'package:canna_go_dev/widget/bottomAppBar/bottomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:canna_go_dev/form/logInForm/logInForm.dart';
import 'package:connectivity/connectivity.dart';



//import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() => runApp(MyApp());

var delifee;
final store = Store<AppState>(reducer,
    initialState: AppState(
        items: [],
        itemFiltersArray: [
          {'name': 'Best Rated', 'selected': false, 'id': 1},
          {'name': 'Alphabatic', 'selected': false, 'id': 2},
          {'name': 'Most Popular', 'selected': false, 'id': 3},
          {'name': 'Recomended', 'selected': false, 'id': 4},
        ],
        demoState: 'Welcome',
        itemCart: [],
        cart: {},
        numberOfItemInCart: 0,
        notificationCount: 0,
        connection: true,
        cartList: [],
        shopList: [],
        isFilter: false,
        filterItemsList: [],
        searchItemList: [],
        isSearch: false,
        isLoadingSearch: false,
        driverLat: 0.0,
        driverLng: 0.0,
        isSocket:"noConnection",
        locationList: [],
        historyOrderList:[],
        visitCheckToMap: false,
        visitItemToMap: false,
        notifiCheck: true,
        notiList: [],
        shopLocationList:[],
        notiToOrder: [],
        isClickFilter: false,
        isHistory: false),
    middleware: [thunkMiddleware]); //middleware: [thunkMiddleware]);
int index = 0;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  bool internet = false;

  @override
  void initState() {
    // Dart client
    // IO.Socket socket = IO.io('https://dynamyk.co/');
    // socket.on('connect', (_) {
    //  print('connect');
    //   socket.emit('msg', 'test');
    // });
    // socket.on('event', (data) => print(data));
    // socket.on('disconnect', (_) => print('disconnect'));
    // socket.on('fromServer', (_) => print(_));

  //  _getSocket();

//  SocketIOManager manager = SocketIOManager();
//     SocketIO socket = manager.createInstance('https://dynamyk.co/');       //TODO change the port  accordingly
//     socket.onConnect((data){
//       print("connected...");
//       print(data);
//       socket.emit("message", ["Hello world!"]);
//     });
//     socket.on("news", (data){   //sample event
//       print("news");
//       print(data);
//     });
//     socket.connect();

    internetCheck();
    _checkIfLoggedIn();
   // _getSocket();

    super.initState();
  }

  void internetCheck() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // print("Connected to Mobile Network");
      setState(() {
        internet = true;
      });
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // print("Connected to WiFi");
      setState(() {
        internet = true;
      });
    } else {
      setState(() {
        internet = false;
      });

      return showMsg(context, "Email is empty");
    }
  }

  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        _isLoggedIn = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Colors.white,
              appBarTheme: AppBarTheme(
                  color: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black))),
          home: _isLoggedIn
              ? StoreConnector<AppState, AppState>(
                  converter: (store) => store.state,
                  builder: (context, items) => Navigation(),
                )
              : LogIn()),
    );
  }
}



// Name:CannaGoKey
// Key ID:NGBLQUXSW3