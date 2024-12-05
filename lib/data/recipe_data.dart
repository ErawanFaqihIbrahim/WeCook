
import 'package:firstui/models/recipe_model.dart';

final List<Recipe> recipes = [

  Recipe(
    id: 1,
    title: 'Telur dadar sehat',
    description: 'Telur dadar praktis untuk sarapan.',
    imageUrl: 'https://cdn0-production-images-kly.akamaized.net/mkAcKHQQm2Ujwq0LngbV5KHKOp4=/1979x0:4981x4001/500x667/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/2843447/original/098533600_1562138068-shutterstock_1335756413.jpg',
    ingredients: [
        '2 butir telur',
        'Sejumput garam',
        'Sedikit minyak goreng'
    ],
    steps: [
        'Kocok telur dan tambahkan garam.',
        'Panaskan minyak di wajan.',
        'Tuang adonan telur dan masak hingga matang'
      ],
    category: 'foods'
    ),

    Recipe(
      id: 2,
      title: 'Nasi Goreng',
      description: 'Nasi goreng spesial ala Indonesia',
      imageUrl: 'https://cdn1-production-images-kly.akamaized.net/a6xvLhjIWqlrNOdjaI40qxT_Jr0=/0x148:1920x1230/640x360/filters:quality(75):strip_icc():format(webp)/kly-media-production/medias/3093328/original/069244600_1585909700-fried-2509089_1920.jpg',
      ingredients:  [
        '1 piring nasi',
        '2 siung bawang putih',
        '1 sendok teh kecap'
      ],
      steps: [
        'Panaskan minyak',
        'Tumis bawang putih',
        'Masukkan nasi dan kecap, lalu aduk rata'
      ],
      category: 'foods'
    ),

    Recipe(
      id: 3,
      title: 'Mie Goreng',
      description: 'Mie goreng lezat dengan sayuran',
      imageUrl: 'https://www.masakapahariini.com/wp-content/uploads/2023/11/Resep-Mie-Goreng-Telur-Untuk-Tanggal-Tua.jpg',
      ingredients: [
        '100 gram mie',
        '1 buah wortel',
        '2 sendok makan kecap manis'
      ],
      steps: [
        'Rebus mie hingga matang',
        'Panaskan minyak dan tumis sayuran',
        'Masukkan mie dan kecap, lalu aduk rata'
      ],
      category: 'foods'
      ),

      Recipe(
      id: 4,
      title: 'Jus Jeruk',
      description: 'Jus Jeruk',
      imageUrl: 'https://www.masakapahariini.com/wp-content/uploads/2023/11/Resep-Mie-Goreng-Telur-Untuk-Tanggal-Tua.jpg',
      ingredients: [
        'Jus Jeruk',
        'Jus Jeruk',
      ],
      steps: [
        'Jus Jeruk',
        'Jus Jeruk',
        'Jus Jeruk'
      ],
      category: 'drinks'
      ),
  ];

