
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: Container(
        color: Colors.blue,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              

              accountName: Text('Name'),
        
              accountEmail: Text('Email.gmail.com'),
              currentAccountPicture: Icon(Icons.account_circle,size: 80,color: Colors.white),
              ),
              ListTile(
                
                onTap: (){},
                leading: Icon(Icons.shopping_cart),
                title: Text('Cart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
               ListTile(
                onTap: (){},
                leading: Icon(Icons.shopping_cart),
                title: Text('Cart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
               ListTile(
                onTap: (){},
                leading: Icon(Icons.shopping_cart),
                title: Text('Cart',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              ),
          ],
        ),
      ),

      
    );
  }
}