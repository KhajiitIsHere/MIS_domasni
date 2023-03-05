import 'dart:convert';

import 'package:domasno2/model/burger.dart';
import 'package:domasno2/model/current_page.dart';
import 'package:domasno2/model/ingredient_type.dart';
import 'package:domasno2/pages/account_page.dart';
import 'package:domasno2/pages/burgers_page.dart';
import 'package:domasno2/pages/camera_page.dart';
import 'package:domasno2/pages/home_page.dart';
import 'package:domasno2/pages/user_form.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './pages/map_page.dart';
import 'package:domasno2/services/local_notice_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:camera/camera.dart';

import 'model/ingredient.dart';
import 'model/named_burger.dart';
import 'model/user.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(MyApp(camera: firstCamera));
}

class MyApp extends StatefulWidget {
  final CameraDescription camera;

  MyApp({required this.camera, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Map<IngredientType, List<Ingredient>> ingredients;

  final List<Marker> burgerStores = const [
    Marker(markerId: MarkerId('0'), position: LatLng(42.00325867671412, 21.400483970814815)),
    Marker(markerId: MarkerId('0'), position: LatLng(41.99224848049097, 21.427083912783882)),
    Marker(markerId: MarkerId('0'), position: LatLng(41.99736456618666, 21.451326897869723)),
  ];

  Future<Map<IngredientType, List<Ingredient>>> fetchIngredients() async {
    final response = await get(Uri.parse(
        'https://react-http-requests-f6d8b-default-rtdb.europe-west1.firebasedatabase.app/ingredients.json'));

    final Map<IngredientType, List<Ingredient>> ingredients = {
      IngredientType.buns: [],
      IngredientType.meat: [],
      IngredientType.cheese: [],
      IngredientType.sauces: [],
      IngredientType.salad: [],
    };

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      List<Ingredient> getIngredients(List<dynamic> ings) =>
          ings.map((e) => Ingredient.fromJson(e)).toList();

      ingredients[IngredientType.buns] = getIngredients(data['buns'] ?? []);
      ingredients[IngredientType.meat] = getIngredients(data['meat'] ?? []);
      ingredients[IngredientType.cheese] = getIngredients(data['cheese'] ?? []);
      ingredients[IngredientType.sauces] = getIngredients(data['sauces'] ?? []);
      ingredients[IngredientType.salad] = getIngredients(data['salad'] ?? []);

      return ingredients;
    } else {
      print('Failed to fetch data');
      return ingredients;
    }
  }

  final List<NamedBurger> savedBurgers = [];

  final List<User> users = [];

  User? loggedInUser;

  CurrentPage currentPage = CurrentPage.homePage;

  final notificationService = LocalNoticeService.getService();

  @override
  void initState() {
    super.initState();
    fetchIngredients().then((value) => ingredients = value);
  }

  void handleOrder(Burger burger, String address) {
    notificationService.showNotification(
        'Burger Order', 'Burger ${burger.toString()} ordered on $address');
  }

  void handleSave(NamedBurger burger) {
    setState(() {
      savedBurgers.add(burger);
    });
  }

  void login(String username, String password) {
    for (User user in users) {
      if (user.name == username && user.password == password) {
        setState(() {
          loggedInUser = user;
        });
        break;
      }
    }
  }

  void logout() {
    setState(() {
      loggedInUser = null;
    });
  }

  void register(String username, String password, String phoneNumber) {
    if (users.any((user) => user.name == username)) {
      return;
    }

    final user =
        User(name: username, password: password, phoneNumber: phoneNumber);

    setState(() {
      users.add(user);
      loggedInUser = user;
    });
  }

  List<NamedBurger> getSavedBurgersForUser(User user) {
    return savedBurgers
        .where((burger) => burger.creator.phoneNumber == user.phoneNumber)
        .toList();
  }

  get body {
    if (loggedInUser == null) {
      return UserForm(doLogin: login, doRegister: register);
    } else if (currentPage == CurrentPage.homePage) {
      return HomePage(
        ingredients: ingredients,
        loggedInUser: loggedInUser!,
        onSave: handleSave,
        onOrder: handleOrder,
        openAccountPage: () => setState(() {
          currentPage = CurrentPage.account;
        }),
        openBurgersPage: () => setState(() {
          currentPage = CurrentPage.savedBurgers;
        }),
        openMapPage: () => setState(() {
          currentPage = CurrentPage.map;
        }),
        openCameraPage: () => setState(() {
          currentPage = CurrentPage.camera;
        }),
      );
    } else if (currentPage == CurrentPage.savedBurgers) {
      return BurgersPage(
        burgers: getSavedBurgersForUser(loggedInUser!),
        loggedInUser: loggedInUser!,
        onOrder: handleOrder,
        openHomePage: () => setState(() {
          currentPage = CurrentPage.homePage;
        }),
      );
    } else if (currentPage == CurrentPage.account) {
      return AccountPage(
        user: loggedInUser!,
        openHomePage: () => setState(() {
          currentPage = CurrentPage.homePage;
        }),
        addAddress: (address) => setState(() {
          loggedInUser!.addAddress(address);
        }),
        logout: logout,
      );
    } else if (currentPage == CurrentPage.map) {
      return MapPage(
        toggleMap: () => setState(() {
          currentPage = CurrentPage.homePage;
        }),
        burgerStores: burgerStores,
      );
    } else if(currentPage == CurrentPage.camera) {
      return CameraPage(camera: widget.camera, openHomePage: () => setState(() {
        currentPage = CurrentPage.homePage;
      }),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: body,
    );
  }
}
