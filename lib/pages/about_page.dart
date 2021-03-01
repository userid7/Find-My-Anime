import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String aboutBody = '''
        Find My Anime mobile app is image tracer for a screenshot of an anime. With this app you can find the anime name, the episode number, even the timestamp of the scene with the single scene of the anime.

        This app developed by userid7 using Flutter framework based on trace.moe API by soruly.''';

    String usageBody = '''
        You just need to upload your image of scene of an anime by clicking button with camera icon and the click the "Find My Anime!" button. Viola! thats it. The list of scene with smiliar scene of your anime will appear by order of confidence level. You can tap to the list to see the preview video of the result.
        
        If you find that the result is not match with your scene, please try with another scene of your anime.''';

    String tracemoeBody = '''
        trace.moe is an Anime Scene Search Engine that helps users to trace back the original anime by a screenshot. It search in ~30000 hours of anime and find the best matching scene. It can tell the anime, the episode and the exact time that scene appears. Since the search result may not be correct, it provides a few seconds of preview for verification. There has been a lot of anime screencaps and GIFs spreading around the internet without quoting the source. And trace.moe is built to fix that, helping people to get to know the source anime, not just some random piece of work in content farms.
        
        trace.moe is a free service and has no Ads. It relies entirely on donations for its operational costs.''';

    var hdiwBody = '''
        It uses a technology called Content-based image retrieval. No Machine Learning / Neural Network used. No recognition power, Not train-able. See presentation slides: 
        https://github.com/soruly/slides''';

    var creditBody = '''
        Lux Mathias, Savvas A. Chatzichristofis. Lire: Lucene Image Retrieval – An Extensible Java CBIR Library. In proceedings of the 16th ACM International Conference on Multimedia, pp. 1085-1088, Vancouver, Canada, 2008 Visual Information Retrieval with Java and LIRE''';

    double spacer = 30;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: GoogleFonts.exo(
            textStyle: TextStyle(
              fontSize: 21,
              letterSpacing: .5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TitleText(
                  text: "About",
                ),
                Divider(
                  thickness: 3,
                ),
                BodyText(text: aboutBody),
                SizedBox(height: spacer),
                TitleText(
                  text: "Usage",
                ),
                Divider(
                  thickness: 3,
                ),
                BodyText(text: usageBody),
                SizedBox(height: spacer),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TitleText(
                      text: "trace.moe ",
                    ),
                    Text("(based on official website)")
                  ],
                ),
                Divider(
                  thickness: 3,
                ),
                BodyText(text: tracemoeBody),
                // SizedBox(height: spacer),
                // TitleText(
                //   text: "How Does It Work?",
                // ),
                // Divider(
                //   thickness: 3,
                // ),
                // BodyText(text: hdiwBody),
                // SizedBox(height: spacer),
                // TitleText(
                //   text: "Credit",
                // ),
                // Divider(
                //   thickness: 3,
                // ),
                // BodyText(text: creditBody),
                SizedBox(height: spacer),
                TitleText(
                  text: "Donate",
                ),
                Divider(
                  thickness: 3,
                ),
                BodyText(
                    text: "Support Soruly to develop more great product! "),
                SizedBox(height: 20),
                SupportButton(
                  text: "Patreon",
                  icon: FontAwesomeIcons.patreon,
                  bgColor: Colors.red[200],
                  url: "https://www.patreon.com/soruly",
                ),
                SizedBox(height: 10),
                SupportButton(
                  text: "PayPal",
                  icon: FontAwesomeIcons.paypal,
                  bgColor: Colors.blue[800],
                  url: "https://www.paypal.com/paypalme/soruly",
                ),
                SizedBox(height: 10),
                SupportButton(
                  text: "GitHub",
                  icon: FontAwesomeIcons.github,
                  bgColor: Colors.black87,
                  url: "https://github.com/sponsors/soruly",
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SupportButton extends StatelessWidget {
  const SupportButton({
    Key key,
    @required this.text,
    @required this.bgColor,
    @required this.icon,
    @required this.url,
  }) : super(key: key);

  final String text;
  final Color bgColor;
  final IconData icon;
  final String url;

  _launchURL() async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: SizedBox(
          width: 240,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: bgColor, // background
              onPrimary: Colors.white, // foreground
            ),
            onPressed: () {
              _launchURL();
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      flex: 10,
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: VerticalDivider(
                        thickness: 2,
                        color: Colors.black45,
                      ),
                    ),
                    Expanded(flex: 2, child: FaIcon(icon)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: Colors.orange[700],
          fontSize: 25,
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.exo(
        textStyle: TextStyle(
          fontSize: 14,
          letterSpacing: .5,
        ),
      ),
    );
  }
}
