import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Cook',
      home: RecipeListPage(),
    );
  }
}

class RecipeListPage extends StatelessWidget {
  final List<Map<String, dynamic>> recipes = [
    {
      'title': 'Telur dadar sehat',
      'description': 'Telur dadar praktis untuk sarapan.',
      'imageUrl' : 'https://cdn0-production-images-kly.akamaized.net/mkAcKHQQm2Ujwq0LngbV5KHKOp4=/1979x0:4981x4001/500x667/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/2843447/original/098533600_1562138068-shutterstock_1335756413.jpg',
      'ingredients': [
        '2 butir telur',
        'Sejumput garam',
        'Sedikit minyak goreng'
      ],
      'steps': [
        'Kocok telur dan tambahkan garam.',
        'Panaskan minyak di wajan.',
        'Tuang adonan telur dan masak hingga matang'
      ]
    },
    {
      'title': 'Nasi Goreng',
      'description': 'Nasi goreng spesial ala Indonesia',
      'imageUrl': 'https://cdn1-production-images-kly.akamaized.net/a6xvLhjIWqlrNOdjaI40qxT_Jr0=/0x148:1920x1230/640x360/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3093328/original/069244600_1585909700-fried-2509089_1920.jpg',
      'ingredients': [
        '1 piring nasi',
        '2 siung bawang putih',
        '1 sendok teh kecap'
      ],
      'steps': [
        'Panaskan minyak',
        'Tumis bawang putih',
        'Masukkan nasi dan kecap, lalu aduk rata'
      ]
    },
    {
      'title': 'Mie Goreng',
      'description': 'Mie goreng lezat dengan sayuran',
      'imageUrl': 'https://www.masakapahariini.com/wp-content/uploads/2023/11/Resep-Mie-Goreng-Telur-Untuk-Tanggal-Tua.jpg',
      'ingredients': [
        '100 gram mie',
        '1 buah wortel',
        '2 sendok makan kecap manis'
      ],
      'steps': [
        'Rebus mie hingga matang',
        'Panaskan minyak dan tumis sayuran',
        'Masukkan mie dan kecap, lalu aduk rata'
      ]
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('We Cook'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.orange.shade100,
            child: ListTile(
              leading: Image.network(
                recipes[index]['imageUrl']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                recipes[index]['title']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                recipes[index]['description']!),
              onTap: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailPage(recipe: recipes[index]),
                  ),
                );
              },
            ),
          );
        }
      )
    );
  }
}

class RecipeDetailPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title']!),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            recipe['imageUrl']!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 16),
          Text(
            recipe['title']!,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Bahan-bahan',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe['ingredients'].length,
            itemBuilder: (context, index) {
              return Text(
                '-${recipe['ingredients'][index]}',
                style: TextStyle(fontSize: 16),
              );
            },
          ),
          SizedBox(height: 16),
          Text(
            'Langkah Pembuatan:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: recipe['steps'].length,
            itemBuilder: (context, index) {
              return Text(
                '${index + 1}. ${recipe['steps'][index]}',
                style: TextStyle(fontSize: 16),
              );
            },
          ),
        ],
      ),
      ),
    );
  }
}