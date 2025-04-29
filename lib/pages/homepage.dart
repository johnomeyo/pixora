import 'package:flutter/material.dart';
import 'package:pixora/models/topic_model.dart' show Topic;
import 'package:pixora/pages/wallpapers_page.dart' show WallpapersPage;

class Homepage extends StatelessWidget {
  final List<Topic> topics = [
    Topic(
      title: 'Drawings',
      imageUrl:
          'https://i.pinimg.com/736x/f0/c9/45/f0c945c44c030194ce0bf9df0c8bb0b4.jpg',
    ),
    Topic(
      title: 'Abstaract',
      imageUrl:
          'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTl8fGFic3RyYWN0fGVufDB8fDB8fHww',
    ),
    Topic(
      title: 'Beach',
      imageUrl:
          'https://images.unsplash.com/photo-1559494007-9f5847c49d94?q=80&w=1374&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Topic(
      title: 'Anime',
      imageUrl:
          'https://r1.ilikewallpaper.net/iphone-wallpapers/download-109660/Levi-Ackermann-Red-moon_640.jpg',
    ),
    Topic(
      title: 'Photography',
      imageUrl:
          'https://w0.peakpx.com/wallpaper/187/768/HD-wallpaper-best-wall-paper-2014-leaf-leafwater-waterdrop.jpg',
    ),
    Topic(
      title: 'Design',
      imageUrl:
          'https://i.pinimg.com/736x/32/c6/ae/32c6aeb72513d1c289667c115f5b4f52.jpg',
    ),
    Topic(
      title: 'Art',
      imageUrl:
          'https://wallpaper.forfun.com/fetch/28/28eca9a1687916a12443f74c3ed7ad5b.jpeg',
    ),
    Topic(
      title: 'Dark',
      imageUrl:
          'https://images.wallpapersden.com/image/download/composition-in-dark-mode_bWhsZmyUmZqaraWkpJRobWllrWdma2U.jpg',
    ),
    Topic(
      title: 'Animals',
      imageUrl:
          'https://images.unsplash.com/photo-1474511320723-9a56873867b5?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YW5pbWFsfGVufDB8fDB8fHww',
    ),
    Topic(
      title: '3D Renders',
      imageUrl:
          'https://images.unsplash.com/photo-1622737133809-d95047b9e673?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8M2QlMjByZW5kZXJ8ZW58MHx8MHx8fDA%3D',
    ),
    Topic(
      title: 'Minimalist',
      imageUrl:
          'https://w0.peakpx.com/wallpaper/115/408/HD-wallpaper-iceberg-minimalist.jpg',
    ),
    Topic(
      title: 'Flowers',
      imageUrl:
          'https://live.staticflickr.com/4313/36262232356_ffcffd1848_h.jpg',
    ),
    Topic(
      title: 'Cityscapes',
      imageUrl:
          'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Topic(
      title: 'Cars',
      imageUrl:
          'https://i.pinimg.com/236x/8b/2d/c1/8b2dc19d6521387351460e9b5ba99899.jpg',
    ),
    Topic(
      title: 'Nature',
      imageUrl:
          'https://wallpapers.com/images/hd/1080p-nature-background-nfkrrkh7da3eonyn.jpg',
    ),
  ];

  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text("Welcome to Pinterest")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Pick 5 or more topics", style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Expanded(
              child: GridView.builder(
                itemCount: topics.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => WallpapersPage(topic: topic.title),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(topic.imageUrl),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      alignment: Alignment.bottomLeft,
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        topic.title,
                        style: theme.textTheme.labelLarge!.copyWith(
                          color: Colors.white,
                          shadows: const [
                            Shadow(blurRadius: 2, color: Colors.black),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
