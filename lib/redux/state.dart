
class AppState{
 var demoState;
 var items;
 var itemFiltersArray;
 var itemCart;
 var cart;
 List cartList;
 List shopList;
 List filterItemsList;
 int numberOfItemInCart;
 var notificationCount;
 bool connection;
 var allShop;
 bool isFilter;
 List searchItemList;
 bool isSearch;
 bool isLoadingSearch;
 double driverLat;
 double driverLng;
 String isSocket;
 List locationList;
 List historyOrderList;
 bool visitCheckToMap;
 bool visitItemToMap;
 bool notifiCheck;
 List notiList;
 List shopLocationList;
 List notiToOrder;
 bool isClickFilter;
 bool isHistory;


 AppState({this.itemFiltersArray, this.demoState, this.items, this.itemCart, this.cart, this.numberOfItemInCart,this.notificationCount,this.connection, this.allShop, this.cartList,
  this.shopList, this.isFilter, this.filterItemsList, this.searchItemList, this.isSearch, this.isLoadingSearch, this.driverLat, this.driverLng,this.isSocket,this.locationList,
  this.historyOrderList,this.visitCheckToMap,this.visitItemToMap,this.notifiCheck,this.notiList,this.shopLocationList,this.notiToOrder,
  this.isClickFilter,this.isHistory});

 AppState copywith({itemFiltersArray, demoState, items, itemCart, cart, numberOfItemInCart,notificationCount,connection,allShop,
  cartList, shopList,isFilter,filterItemsList, searchItemList, isSearch,isLoadingSearch,driverLat,driverLng,isSocket,locationList,
  historyOrderList,visitCheckToMap,visitItemToMap,notifiCheck,notiList,shopLocationList,notiToOrder,isClickFilter,isHistory}){
   return AppState(
     demoState: demoState?? this.demoState,
     items: items?? this.items,
     itemFiltersArray: itemFiltersArray?? this.itemFiltersArray,
     itemCart: itemCart ?? this.itemCart,
     cart: cart ?? this.cart, 
     cartList: cartList ?? this.cartList, 
     numberOfItemInCart: cart ?? this.numberOfItemInCart, 
     notificationCount: notificationCount ?? this.notificationCount,
     connection: connection ?? this.connection, 
      allShop: allShop ?? this.allShop, 
       shopList: shopList ?? this.shopList, 
       isFilter: isFilter ?? this.isFilter, 
        filterItemsList: filterItemsList?? this.filterItemsList, 
         searchItemList: searchItemList?? this.searchItemList, 
          isSearch: isSearch ?? this.isSearch, 
          isLoadingSearch: isLoadingSearch ?? this.isLoadingSearch, 
          driverLat: driverLat??this.driverLat,
          driverLng: driverLng??this.driverLng,
          isSocket:isSocket??this.isSocket,
          locationList: locationList??this.locationList,
          historyOrderList: historyOrderList??this.historyOrderList,
          visitCheckToMap:visitCheckToMap??this.visitCheckToMap,
          visitItemToMap:visitItemToMap??this.visitItemToMap,
          notifiCheck:notifiCheck??this.notifiCheck,
          notiList:notiList??this.notiList,
          shopLocationList:shopLocationList??this.shopLocationList,
          notiToOrder:notiToOrder??this.notiToOrder,
          isClickFilter:isClickFilter??this.isClickFilter,
          isHistory:isHistory??this.isHistory
   );
 }
}


