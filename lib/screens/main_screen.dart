import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pawcamkz/screens/feeders/feeder_live_screen.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isListVisible = true;
  bool isMyCitySelected = true;
  late FirebaseFirestore db;
  late Reference storageRef;

  @override
  void initState() {
    db = FirebaseFirestore.instance;
    storageRef = FirebaseStorage.instance.ref();
  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(        title: Text('Активные кормушки', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),), centerTitle: false, actions: [Row(children: [Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMyCitySelected = !isMyCitySelected;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Text(isMyCitySelected ? 'Только мой город' : 'Все города', style: TextStyle(color: Theme.of(context).colorScheme.background,),),
                        ),
                      ),
                    ),
                  )],)],),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: db.collection("feeders").snapshots(),
            builder: (context, snapshot) {
              return Stack(
                
                children: [
                  
                  
                  Visibility(
                    visible: isListVisible,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey[50]),
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length ?? 0,
                          itemBuilder: (context, index) {
                            return _card(snapshot.data?.docs[index]);
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32, left: 12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isListVisible = !isListVisible;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12))),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      isListVisible ? Icons.map_outlined : Icons.list,
                                        color: Theme.of(context).colorScheme.background,

                                      ),
                                    
                                  ),
                                                                    Text(isListVisible ? 'Карта' : 'Список', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight, fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize)),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 32, left: 40),
                          child: GestureDetector(
                            onTap: () {
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  borderRadius:
                                      const BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8),
                                          child: Icon(
                                                      Icons.auto_fix_high_rounded,
                                                      
                                                      color: Theme.of(context).colorScheme.background,
                                                    ),
                                        ),
                              Text('Случайная кормушка', style: TextStyle(color: Theme.of(context).colorScheme.background, fontWeight: Theme.of(context).textTheme.bodyMedium?.fontWeight, fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize),),
                            ],
                          ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              );
            }));
  }

  _card(QueryDocumentSnapshot? doc) {
  String url = doc?.get('url') ?? '';
  String title = doc?.get('title') ?? '';
  int connections = doc?.get('connections') ?? 0;

  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeederLiveScreen(
            url: url,
            title: title,
            connections: connections,
          ),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: 8,
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        doc?.get('city') ?? '',
                        style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 14),
                      ),
                    ],
                  ),
                  
                
              
            
          ),
        ),
      ),
    );
  
}

}