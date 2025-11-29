
import 'dart:html' as html; // Only used for Web
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const BwPortfolioApp());
}

class BwPortfolioApp extends StatelessWidget {
  const BwPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HIREN'S PORTFOLIO",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black, // Pure Black
        textTheme: GoogleFonts.spaceGroteskTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const MouseHomePage(),
    );
  }
}

class MouseHomePage extends StatefulWidget {
  const MouseHomePage({super.key});

  @override
  State<MouseHomePage> createState() => _MouseHomePageState();
}

class _MouseHomePageState extends State<MouseHomePage> {
  Offset _mousePos = Offset.zero;

  // --- 1. KEYS FOR SCROLLING (Aa keys thi jagya nakki thase) ---
  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _workKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // --- 2. PROJECT LIST ---
  final List<Map<String, String>> myProjects = [
    {
      "number": "01",
      "title": "E-Commerce App",
      "desc": "A complete shopping app with payment gateway integration.",
      "image": "https://images.unsplash.com/photo-1592503254549-d83d24a4dfab?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "number": "02",
      "title": "Wavee Ai",
      "desc": "Wavee AI brings together residents, concierge teams, and local businesses into one intuitive app designed",
      "image": "https://www.forbes.com.au/wp-content/uploads/2025/11/wav.png",
    },
    {
      "number": "03",
      "title": "AI Chat Bot",
      "desc": "Integrated ChatGPT API for smart conversation.",
      "image": "https://images.unsplash.com/photo-1677442136019-21780ecad995?auto=format&fit=crop&w=800&q=80",
    },
  ];

  // --- 3. SCROLL FUNCTION (Aa function scroll karse) ---
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(seconds: 1), // 1 second nu animation
      curve: Curves.easeInOut, // Smooth speed
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Scaffold(
      backgroundColor: Colors.black,
      body: MouseRegion(
        onHover: (event) {
          setState(() {
            _mousePos = event.position;
          });
        },
        child: Stack(
          children: [
            // --- Layer 1: Background Light ---
            Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment(
                    (_mousePos.dx / width) * 2 - 1,
                    (_mousePos.dy / MediaQuery.of(context).size.height) * 2 - 1,
                  ),
                  radius: 0.8,
                  colors: [
                    Colors.white.withOpacity(0.15),
                    Colors.black,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),

            // --- Layer 2: Main Content ---
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Navbar (Have Button par Tap function mukyu che) ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("MY PORTFOLIO.", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          Row(
                            children: [
                              // Home par click karta HomeKey par jase
                              _navLink("Home", () => _scrollToSection(_homeKey)),
                              const SizedBox(width: 20),
                              // Work par click karta WorkKey par jase
                              _navLink("Work", () => _scrollToSection(_workKey)),
                              const SizedBox(width: 20),
                              // Contact par click karta ContactKey par jase
                              _navLink("Contact", () => _scrollToSection(_contactKey)),
                            ],
                          )
                        ],
                      ),

                      const SizedBox(height: 100),

                      // --- Hero Section (Attached Home Key) ---
                      Container(
                        key: _homeKey, // <--- AHIN KEY MUKI
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "HELLO, I AM",
                              style: TextStyle(color: Colors.grey[600], letterSpacing: 2),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "HIREN CHANDALIYA",
                              style: TextStyle(
                                fontSize: isMobile ? 50 : 90,
                                fontWeight: FontWeight.w900,
                                height: 0.9,
                                letterSpacing: -2,
                              ),
                            ),
                            Text(
                              "FLUTTER DEVELOPER",
                              style: TextStyle(
                                fontSize: isMobile ? 50 : 90,
                                fontWeight: FontWeight.w900,
                                height: 0.9,
                                letterSpacing: -2,
                                color: Colors.grey[800],
                              ),
                            ),
                            const SizedBox(height: 50),
                            const Text(
                              "I create high-performance apps and websites using Flutter.\nCheck out my latest work below.",
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 150),

                      // --- Projects Section (Attached Work Key) ---
                      Container(
                        key: _workKey, // <--- AHIN KEY MUKI
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Divider(color: Colors.white24),
                            const SizedBox(height: 50),
                            const Text("SELECTED WORK / GITHUB REPOS", style: TextStyle(fontSize: 14, letterSpacing: 2)),
                            const SizedBox(height: 50),
                          ],
                        ),
                      ),

                      // Project List
                      ...myProjects.map((project) {
                        return Column(
                          children: [
                            _buildProjectItem(
                              isMobile,
                              project['number']!,
                              project['title']!,
                              project['desc']!,
                              project['image']!,
                            ),
                            const SizedBox(height: 80),
                          ],
                        );
                      }).toList(),

                      const SizedBox(height: 100),

                      // --- Footer (Attached Contact Key) ---
                      Container(
                        key: _contactKey, // <--- AHIN KEY MUKI
                        padding: const EdgeInsets.all(50),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24),
                        ),
                        child: Column(
                          children: [
                            const Text("LET'S WORK TOGETHER", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20),
                            const Text("hirenpchandaliya@gmail.com", style: TextStyle(fontSize: 18, color: Colors.grey)),
                            const SizedBox(height: 30),
                            ElevatedButton.icon(
                              onPressed: () {
                                // openGitHub("https://github.com/HirenChandaliya");
                                openGitHub();
                              },
                              icon: const Icon(Icons.code),
                              label: const Text("VISIT GITHUB PROFILE"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),

            // --- Layer 3: Pointer ---
            Positioned(
              left: _mousePos.dx - 20,
              top: _mousePos.dy - 20,
              child: IgnorePointer(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Updated Nav Link with Click Event ---
  Widget _navLink(String text, VoidCallback onTap) {
    return InkWell( // TextButton ni jagyae InkWell vaparyu jethi click kari shakay
      onTap: onTap,
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
    );
  }

  Widget _buildProjectItem(bool isMobile, String number, String title, String desc, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: isMobile ? 200 : 400,
          decoration: BoxDecoration(
            color: Colors.grey[900],
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
              colorFilter: const ColorFilter.mode(Colors.black45, BlendMode.darken),
            ),
            border: Border.all(color: Colors.white24),
          ),
          child: Center(
            child: Icon(Icons.touch_app, color: Colors.white.withOpacity(0.5), size: 50),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(number, style: const TextStyle(fontSize: 20, color: Colors.grey)),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(desc, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 20),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("VIEW ON GITHUB"),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  // Future<void> openGitHub(String URL) async {
  //   final url = Uri.parse(URL);
  //   if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  Future<void> openGitHub() async {
    final url = Uri.parse("https://github.com/HirenChandaliya");

    if (kIsWeb) {
      // Web redirect
      html.window.open(url.toString(), "_blank");
    } else {
      // Mobile / Desktop
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not launch $url");
      }
    }
  }

}