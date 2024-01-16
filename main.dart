import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

final player=AudioPlayer()..setReleaseMode(ReleaseMode.loop);

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final tabs=[
    screen1(),
    screen2(),
    screen3(),
    screen4(),
  ];

  int previousIndex=0;
  int currentIndex=0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的自傳',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
                       useMaterial3: true,),
      home: Scaffold(
        appBar: AppBar(title: Text('我的自傳'),
                       backgroundColor: Colors.green,
                ),
        body: tabs[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.green,
          selectedItemColor: Colors.red,
          selectedFontSize: 18,
          unselectedFontSize: 14,
          iconSize: 30,
          currentIndex: currentIndex,
          items: [
            BottomNavigationBarItem(icon: currentIndex==0? Image.asset('images/f1.jpg',width:40,height:40): Image.asset('images/f1.jpg',width:20,height:20), label:'自我介紹',),
            BottomNavigationBarItem(icon: Icon(Icons.school), label:'學習歷程',),
            BottomNavigationBarItem(icon: Icon(Icons.schedule_outlined), label:'學習計畫',),
            BottomNavigationBarItem(icon: Icon(Icons.engineering), label:'專業方向',),
          ],
          onTap: (index) {
            setState(() {
              previousIndex=currentIndex;
              currentIndex=index;
              if (index==0) {
                if (previousIndex==currentIndex) player.resume();
                player.stop();
              }
              if (index==1) {
                if (previousIndex==currentIndex) player.resume();
                player.stop();
              }
              if (index==2) {
                if (previousIndex==currentIndex) player.resume();
                player.stop();
              }
              if (index==3) {
                if (previousIndex==currentIndex) player.resume();
                player.stop();
              }
            });
          },
        ),
      ),
    );
  }
}

class screen1 extends StatelessWidget {

  final String s1=
      '我是陳柏菘，一位對生活充滿熱情、勇於追求夢想的個體。我深信人生的旅程是一場不斷學習、成長的冒險，而這正是我所追求的。'

      '我的生命開始於一個平凡的家庭，父母是平凡而堅強的人，他們教導我堅持夢想的重要性，並且激勵我勇敢迎接挑戰。這樣的教誨成就了我努力向前的信念，塑造了我面對困難時不屈不撓的性格。'

      '在學業方面，我一直以來都抱持著對知識的渴望。我的求學歷程充滿了探索和發現，這不僅僅是為了取得一張文憑，更是為了增進自己的見識，將學到的知識轉化為實踐的力量。無論是在課堂上還是課外活動，我都努力追求卓越，並且樂於與他人分享所學。'

      '我的興趣和熱愛橫跨多個領域。我熱愛健身，運動彷彿是我的靈魂之舞，我喜歡挑戰各種健身項目，這讓我在運動的領域中找到身心靈的平衡。同時，我對於科技和創新充滿好奇心，不斷追蹤科技發展的最前線，期望能夠參與並影響未來的科技演進。'

      '除此之外，我深信服務社會的力量。參與志工活動是我人生中一個重要的部分，透過奉獻愛心和時間，我體會到了幫助他人所帶來的深刻滿足感。這也激發了我對社會公益和可持續發展的興趣，期望自己能夠成為社會進步的一份子。'

      '未來，我期待挑戰更多的可能性，勇敢探索未知的領域。我將以堅定的信念和積極的態度，繼續追求夢想，成為一個對社會有所貢獻、充滿活力的個體。我的人生故事還在繼續書寫，而我希望這段故事能夠成為啟發他人的動力，共同演繹精彩的人生篇章。';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //放標題
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text('Who am I', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          //自傳部份
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(30, 0, 30, 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width:3),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.green, offset: Offset(6, 6)),
              ],
            ),
            child: Text(s1, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 10,),
          //放一張照片
          Container(
            color: Colors.redAccent,
            child:Image.asset('images/f1.jpg'),
            height: 200,
            width: 200,
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150,
                height:150,
                decoration: BoxDecoration(
                  border: Border.all(width:2, color: Colors.lightGreenAccent, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: AssetImage('images/f2.jpg'), fit: BoxFit.cover),
                ),
                //color: Colors.white,
              ),
              Container(
                width: 150,
                height:150,
                decoration: BoxDecoration(
                  border: Border.all(width:2, color: Colors.lightGreenAccent, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(image: AssetImage('images/f3.jpg'), fit: BoxFit.cover),
                ),
                //color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class screen2 extends StatelessWidget {
  final String s1='大學的資工系學習讓我感受到了學問的廣博和科技的無限可能性。在大一的時候，我接觸到了程式設計的基礎，從C語言到Java，再到Python，每一門語言都為我打開了一扇通向不同世界的門。透過編寫各種小型程式和專案，我深深體會到了編程的樂趣和挑戰。'

  '大學的前兩年裡，我主修了資料結構、演算法、離散數學等基礎課程，建立了扎實的理論基礎。同時，我也參與了一些校內外的程式競賽和專案，這不僅鍛煉了我的解決問題的能力，還提高了我在團隊中協作的技巧。'

  '進入大三後，我開始專攻更深層次的資工專業課程，如資料庫系統、網路程式設計、人工智慧等。這些課程的學習加深了我對系統架構和應用開發的理解。我也投入了一些實習計畫，與業界合作，實際應用所學於真實專案中。'

  '除了學術方面，我也積極參與了一些學術研究和社團活動，擔任過資工學會的幹部，參與了一些校內的技術分享和工作坊。這些經歷讓我不僅學到了更多實用的技能，還結交了許多志同道合的夥伴。'

  '在這個快速發展的資訊時代，我深知自己還有很多需要學習和探索的領域。未來，我希望能夠將所學應用於解決真實的社會問題，並繼續深耕自己的專業領域。我期待著在資工領域迎接更多挑戰，不斷超越自己，成為一名對社會有所貢獻的資訊工程師。';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //放標題
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text('What I Learn', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          //自傳部份
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(30, 0, 30, 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width:3),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.green, offset: Offset(6, 6)),
              ],
            ),
            child: Text(s1, style: TextStyle(fontSize: 20)),
          ),
                //color: Colors.white,
            ],
          ),
      );
  }
}
class screen3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white, // 背景顏色白色
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '大一時期',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.red, // 文字顏色紅色
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green, // 容器顏色綠色
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    Text('      1. 學好英文'),
                    Text('      2. 組合語言'),
                    Text('      3. 考取證照'),
                    Text('      4. 人際關係'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Text(
            '大二時期',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    Text('      1. 離散數學'),
                    Text('      2. 線性代數'),
                    Text('      3. 多益550'),
                    Text('      4. 人際關係'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('大三時期',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    Text('      1. 專題研究'),
                    Text('      2. 演算法'),
                    Text('      3.鎖定面標研究所'),
                    Text('      4. 沉靜心靈'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('大四時期',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 100,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView(
                  children: [
                    Text('      1. 圖書館總複習'),
                    Text('      2. 英文面試練習'),
                    Text('      3. 考古題複習'),
                    Text('      4. 研究所面試'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class screen4 extends StatelessWidget {
  final String s1='我渴望成為一位資安工程師，我的未來專業方向將注重在不斷變化的資訊安全領域中不斷精進。資安工程師是當今科技領域中至關重要的一環，隨著科技的不斷進步，保護系統和資訊安全變得更加挑戰而且迫切。'

  '我將專注於深入研究網路安全，以確保數據在傳輸過程中的保密性和完整性。我計劃深入瞭解防火牆、入侵檢測系統和虛擬私人網路（VPN）等技術，以應對日益複雜的網路攻擊。'

  '關注應用程式安全性，尤其是在開發和測試階段強化應用程式的防禦機制。這涵蓋了代碼審查、滲透測試和脆弱性評估，以減少應用程式受到攻擊的風險。'

  '追蹤新興技術，如物聯網（IoT）和雲端安全，並確保這些技術能夠在安全的環境中運作。這需要持續學習和適應，以因應資安領域的快速變化。'

  '參與資安社群，與其他專業人士分享經驗和最佳實踐。透過參與安全會議、培訓和合作項目，我將不斷擴展我的專業網絡並保持與行業的聯繫。'

  '總結我的專業方向是在資安領域中建立全面的技術知識，強化系統和數據的安全性，以應對不斷演進的威脅。這將是一個具有挑戰性和充滿滿足感的旅程，我期待著成為資安領域的專業人士。';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //放標題
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Text('Major Field', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ),
          //自傳部份
          Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(30, 0, 30, 50),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width:3),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(color: Colors.green, offset: Offset(6, 6)),
              ],
            ),
            child: Text(s1, style: TextStyle(fontSize: 20)),
          ),
          //color: Colors.white,
        ],
      ),
    );
  }
}