import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

import '../../../data/entertainment_reponse.dart';
import '../../../data/headline_response.dart';
import '../../../data/sports_main.dart';
import '../../../data/technology_reponse.dart';
import '../../home/views/home_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    final ScrollController scrollController = ScrollController();
    final auth = GetStorage();

    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await auth.erase();
              Get.offAll(() => HomeView());
            },
            backgroundColor: Colors.redAccent,
            child: const Icon(Icons.logout_rounded),
          ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text(
                    "Hallo",
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                    auth.read('full_name').toString(),
                    textAlign: TextAlign.end,
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.only(right: 10),
                    width: 50.0,
                    height: 50.0,
                    child: Lottie.network(
                        'https://gist.githubusercontent.com/olipiskandar/2095343e6b34255dcfb042166c4a3283/raw/d76e1121a2124640481edcf6e7712130304d6236/praujikom_kucing.json',
                        fit: BoxFit.cover),
                  ),
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: TabBar(
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.label,
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: [
                      Tab(
                        text: "Headline",
                      ),
                      Tab(
                        text: "Teknologi",
                      ),
                      Tab(
                        text: "Olahraga",
                      ),
                      Tab(
                        text: "Hiburan",
                      ),
                      Tab(
                        text: "Profile",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              headline(
                controller,
                ScrollController(),
              ),
              technology(
                controller,
                ScrollController(),
              ),
              sports(
                controller,
                ScrollController(),
              ),
              entertainment(
                controller,
                ScrollController(),
              ),
              profile(
                context,
                controller,
                ScrollController(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<HeadlineResponse> headline(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<HeadlineResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getHeadline(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber :${snapshot.data!.data![index].name}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<TechnologyResponse> technology(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<TechnologyResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getTechnology(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber :${snapshot.data!.data![index].name}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<SportsResponse> sports(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<SportsResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getSports(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber :${snapshot.data!.data![index].name}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  FutureBuilder<EntertainmentResponse> entertainment(
      DashboardController controller, ScrollController scrollController) {
    return FutureBuilder<EntertainmentResponse>(
      // Mendapatkan future data headline dari controller
      future: controller.getEntertainment(),
      builder: (context, snapshot) {
        // Jika koneksi masih dalam keadaan waiting/tunggu, tampilkan widget Lottie loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Lottie.network(
              // Menggunakan animasi Lottie untuk tampilan loading
              'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
              repeat: true,
              width: MediaQuery.of(context).size.width / 1,
            ),
          );
        }
        // Jika tidak ada data yang diterima, tampilkan pesan "Tidak ada data"
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada data"));
        }

        // Jika data diterima, tampilkan daftar headline dalam bentuk ListView.Builder
        return ListView.builder(
          itemCount: snapshot.data!.data!.length,
          controller: scrollController,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Tampilan untuk setiap item headline dalam ListView.Builder
            return Container(
              padding: const EdgeInsets.only(
                top: 5,
                left: 8,
                right: 8,
                bottom: 5,
              ),
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Widget untuk menampilkan gambar headline dengan menggunakan url gambar dari data yang diterima
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      snapshot.data!.data![index].urlToImage.toString(),
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Widget untuk menampilkan judul headline dengan menggunakan data yang diterima
                        Text(
                          snapshot.data!.data![index].title.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        // Widget untuk menampilkan informasi author dan sumber headline dengan menggunakan data yang diterima
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Author : ${snapshot.data!.data![index].author}'),
                            Text('Sumber :${snapshot.data!.data![index].name}'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget profile(BuildContext context, DashboardController controller,
      ScrollController scrollcontroller) {
    double width = MediaQuery.of(context).size.height;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image(
              height: MediaQuery.of(context).size.height / 3,
              fit: BoxFit.cover,
              image: NetworkImage(
                  'https://tse2.mm.bing.net/th?id=OIP.lR8iLylOIt1b4DFVfZe58QHaEK&pid=Api&P=0'),
            ),
            Positioned(
                child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'https://cdn2.iconfinder.com/data/icons/avatars-99/62/avatar-370-456322-512.png')
            ),),
          ],
        ),
        SizedBox(height: 20,),
        ListTile(title: Text('Rifki Muhamad Fauzi'),),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network('https://cdn-icons-png.flaticon.com/512/2111/2111425.png', height: 35),
              Image.network('https://cdn-icons-png.flaticon.com/512/3059/3059997.png', height: 35),
              Image.network('https://cdn-icons-png.flaticon.com/512/733/733579.png', height: 35),
            ],
          ),
        ListTile(
          title: Text('About Me'),
          subtitle: Text('Hello, introduce my name is Rifki Muhamad Fauzi. I am a student at SMK Assalaam Bandung who is currently learning web programming. For now I already have fundamental knowledge about several programming languages and several frameworks likes PHP, HTML, CSS, Javascript, Bootstrap, Laravel, Flutter, etc.'),
        )
      ],
    );
  }
}
