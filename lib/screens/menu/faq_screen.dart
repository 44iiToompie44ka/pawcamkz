import 'package:flutter/material.dart';

class FaqScreen extends StatelessWidget {
  final List<FaqItem> faqList = [
    FaqItem(
      question: 'Что такое PawCamKz?',
      answer: 'Наше приложение PawCamKz предлагает возможность помочь бездомным котикам, путем пожертвований через умные будки с кормом. ' 'Концепция приложения очень проста: нужны только любовь к котам и желание помочь.'

    ),
    FaqItem(
      question: 'Как это работает?',
      answer: 'Будки с кормом оснащены камерами, они снимают трапезы котов и транслируют в наше приложение. '
      'Пользователи приложения могут сделать пожертвование на корм для бездомных котов, выбрав одну из установленных на улицах будок с кормом. ' 
      'После этого, корм будет разложе автоматически, можно следить за стримом и увидеть, как котики приходят к миске, чтобы поесть. '
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Часто задаваемые вопросы', style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontSize: Theme.of(context).textTheme.titleLarge?.fontSize, fontWeight: Theme.of(context).textTheme.titleLarge?.fontWeight),),
        centerTitle: false,
      ),
      body: ListView.builder(
        itemCount: faqList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              faqList[index].question,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(faqList[index].answer),
            ),
          );
        },
      ),
    );
  }
}

class FaqItem {
  final String question;
  final String answer;

  FaqItem({required this.question, required this.answer});
}
