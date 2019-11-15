import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'action.dart';
import 'state.dart';


ThunkAction <AppState> data = (Store<AppState> store) async{
    store.dispatch(store.state.demoState);
};



ThunkAction <AppState> cartData(d) => (Store<AppState> store) async{
    
   
    store.dispatch(CartAddedItem(d));

};

ThunkAction <AppState> updatedItemFiltersArray(id) => (Store<AppState> store) async{
    // var lists = [];
    // for(var d in store.state.itemFiltersArray){
    //    if(d['id']==id){
    //      d['selected'] = true;
    //    }
    //    lists.add(d);
    // }
    store.state.itemFiltersArray[0]['selected'] = true;
    store.dispatch(FilterItems(store.state.itemFiltersArray));

};


ThunkAction <AppState> deleteItem(d) => (Store<AppState> store) async{

  
    
    // for(var data in store.state.itemCart){
     
    //   if(data.id == d.id ){        
    //     store.state.itemCart.remove(data);
   
    //      }
    // }
 //  print(store.state.itemCart.length);
   store.state.itemCart.removeAt(0);
   store.dispatch(CartListItem(store.state.itemCart));

};



