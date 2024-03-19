import 'package:flutter/material.dart';



class ContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Обратная связь', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),),
        
      ),
      

      body: Column(
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Позвонить нам:', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),),
                
              ),

            ],
          ),
                        const Text("data")


        ],
          ),
        
      );
    
  }
}
