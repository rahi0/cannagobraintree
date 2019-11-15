

import 'package:canna_go_dev/redux/action.dart';
import 'package:canna_go_dev/redux/state.dart';

AppState reducer(AppState state, dynamic action){

  if(action is DemoAction){
    return state.copywith(
      demoState: action.demoAction
    );
  }
  if(action is AllProductItems){
    return state.copywith(
      items: action.items
    );
  }
  if(action is FilterItems){
    
    return state.copywith(
      itemFiltersArray: action.array, 
      demoState : 'this is changed'
    );
  }

  if(action is CartListItem){
  //  print(action.cartListItem.length);
    return state.copywith(
      itemCart: action.cartListItem
    );
  }

  if(action is CartAddedItem){
    return state.copywith(
      cart: action.cartAddedItem
    );
  }
  if(action is UpdateCart){
    return state.copywith(
      cart: action.number+state.numberOfItemInCart
    );
  }

    else if(action is NotificationCountAction){
    return state.copywith(
      notificationCount: action.notificationAction
    );
  }

   if(action is ConnectionCheck){
    return state.copywith(
      connection: action.connectionAction
    );
  }

   if(action is CartList){
 
    return state.copywith(
      cartList: action.cartList
    );
  }
 if(action is ShopList){
 
    return state.copywith(
      shopList: action.shopList
    );
  }

   if(action is CheckFilter){
  
    return state.copywith(
     isFilter: action.isFilter
    );
  }
   if(action is FilterItemsList){

    return state.copywith(
     filterItemsList: action.filterItemsList
    );
  }

   if(action is SearchItemsList){
 
    return state.copywith(
     searchItemList: action.searchItemsList
    );
  }

  if(action is CheckSearch){
  
    return state.copywith(
     isSearch: action.isSearch
    );
  }

  if(action is LoadingSearch){
  
    return state.copywith(
     isLoadingSearch: action.isLoadingSearch
    );
  }

    if(action is DriverLatLng){
  
    return state.copywith(
     driverLat: action.lat,
     driverLng: action.lng
    );
  }

   if(action is DriverSocketConnection){
  
    return state.copywith(
    isSocket: action.socketConnection
    );
  }

    if(action is LocationList){

    return state.copywith(
    locationList: []..addAll(state.locationList)..add(action.locationList)
    );
  }
  
    if(action is HistoryOrderList){

    return state.copywith(
        historyOrderList: action.historyOrderList
    );
  }

    if(action is VisitMapCheck){
  
    return state.copywith(
     visitCheckToMap: action.visitMap
    );
  }
  
    if(action is VisitItemTOMapCheck){
  
    return state.copywith(
   visitItemToMap: action.visitItemToMap
    );
  }

     if(action is NotificationCheck){
  
    return state.copywith(
  notifiCheck: action.notifiCheck
    );
  }

  if(action is NotificationList){
 
    return state.copywith(
    notiList: action.notiList
    );
  }

   if(action is ShopLocationList){
 
    return state.copywith(
    shopLocationList: action.shopLocationList
    );
  }

   if(action is NotiToOrderList){
 
    return state.copywith(
   notiToOrder: action.notiToOrder
    );
  }

  if(action is ClickFilterCheck){
 
    return state.copywith(
  isClickFilter: action.isClickFilter
    );
  }

  
  if(action is HistoryCheck){
 
    return state.copywith(
        isHistory: action.isHistory
    );
  }
  return state;
}