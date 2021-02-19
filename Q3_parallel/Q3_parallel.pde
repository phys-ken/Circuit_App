////////////////////////
BatObj w1;           //
WireObj w2;          //
WireObj w3;          //
RObj w4;             //       オブジェクトを宣言
RObj w5;             //
WireObj w6;          //
WireObj w7;             //
///////////////////////
boolean backFlag = true;


//画面幅や目盛りの太さ等
int kairoWeight = 3;
int memoriWeight = 1;                        //目盛り線の太さ
int graphWeight = 3;                            //グラフ線の太さ
float Vmax = 80;                                  //メモリの最大値
int sizeW = 480;  //setup のサイズも手動で変える必要がある
int sizeH = 480;  //手動
float controlY = 0.9; //上から9/10のところにバーを設置する。
float slidebarX = 0.1;
float VtoggleX = 0.8;
float StoggleX = 0.6;
int bottunSize = 20;


//初期値の規定
int sliderValue = 50;                             //スタイダーの初期値
boolean VtoggleValue =   false;       //Boolean.valueOf(false);
boolean StoggleValue =   false;          //Boolean.valueOf(true);
int textBig = 20;

void setup() {
  size(480, 480);  //手動
  background(255);
  smooth();
  PFont myFont = loadFont("Osaka-48.vlw");
  textFont(myFont);
  textSize(textBig);





  //********************************************この部分を編集//***********************
  //各種ワイヤーオブジェクトをここで定義。                                               //
  // (始点x  始点y  線の長さ　傾き　入力電圧　　出力電圧　　向き)                          //
                                                                                  //
  float x1 = 100;                                                                 //
  float y1 = 300;                                                                 //
  float L1 = 100;                                                                 //
  float L2 = 200;                                                                 //
  float deg = radians(50); //0度〜180度で指定                                       //
  float Vin = 60;                                                                 //
  //float V2 = 30;
  float Gnd  = 0;                                                                 //
                                                                                  //
  w1 = new BatObj(x1, y1, L2, deg, Gnd, Vin, "R");                                //
  w2 = new WireObj(w1.endX, w1.endY, L1, deg, w1.Vout, w1.Vout, "U");             //
  w3 = new WireObj(w2.endX, w2.endY, L1, deg, w2.Vout, w2.Vout, "U");                //
  w4 = new RObj(w2.endX, w2.endY, L2, deg, w2.Vout, Gnd, "L");                //
  w5 = new RObj(w3.endX, w3.endY, L2, deg, w3.Vout, Gnd, "L");                    //
  w6 = new WireObj(w5.endX, w5.endY, L1, deg, Gnd, Gnd, "D");                //
  w7 = new WireObj(w6.endX, w6.endY, L1, deg, Gnd, Gnd, "D"); 
  //********************************************この部分を編集//***********************
}


void draw() {
  background(255);//背景を書き直せば、アニメ化できる！

  //ボタンを描画
  pushStyle();
  stroke(0);
  strokeWeight(2);
  fill(#60FA49);
  int tmpVX = (int)(sizeW * VtoggleX);
  int tmpVY = (int)(sizeH * controlY);
  ellipse(tmpVX, tmpVY, bottunSize, bottunSize);
  fill(0); //塗色を設定する
  text("電圧図", 
    tmpVX -40, tmpVY - textBig - bottunSize/2, 
    200, 100);
  fill(255);


  fill(0); //塗色を設定する
  text("入力電圧  " + floor(sliderValue * 100 / Vmax) + " %", 
    slidebarX * sizeW - bottunSize / 2, controlY * sizeH - bottunSize / 2 - textBig, 
    200, 100);
  fill(255);

  int tmpSX = (int)(sizeW * StoggleX);
  int tmpSY = (int)(sizeH * controlY);
    fill(#60FA49);
  ellipse(tmpSX, tmpSY, bottunSize, bottunSize);
  fill(0); //塗色を設定する
  text("目盛り線", 
    tmpSX -40, tmpSY - textBig - bottunSize/2, 
    200, 100);
  fill(255);


  if (mouseX >=  sizeW * slidebarX - bottunSize / 2 && mouseX <= sizeW * slidebarX + sizeW / 3 - bottunSize / 2
    && mouseY >= controlY * sizeH - bottunSize / 2 && mouseY <= controlY * sizeH + bottunSize / 2) {
    sliderValue = (int) map(mouseX - (sizeW * slidebarX) + bottunSize / 2, 0, sizeW / 3, 0, Vmax);
  }


  noStroke();
    fill(#60FA49);
  int tmpSSLX = (int)(sizeW * slidebarX);
  int tmpSSLY = (int)(sizeH * controlY);
  rect(tmpSSLX - bottunSize / 2, tmpSSLY - bottunSize / 2, (sliderValue / Vmax) * (sizeW / 3), bottunSize);
  
  stroke(0);
  noFill();
  int tmpSLX = (int)(sizeW * slidebarX);
  int tmpSLY = (int)(sizeH * controlY);
  rect(tmpSLX - bottunSize / 2, tmpSLY - bottunSize / 2, (sizeW / 3), bottunSize);

  
  popStyle();


//************************************************************  //スライダーで接続する電圧を設定
  w1.Vout = sliderValue;
  w2.Vin =  sliderValue;
  w3.Vin = sliderValue;
    w4.Vin = sliderValue;
  w5.Vin = sliderValue;

  //回路図を表示する
  strokeWeight(kairoWeight);//回路の線の幅
  w1.displayC();
  w2.displayC();
    w3.displayC();
  w4.displayC();
  w5.displayC();
  w6.displayC();
  w7.displayC();

  // Scale boxを表示する。ifの中に書く
  stroke(0);
  if (StoggleValue) {
    w1.displayS(Vmax, 0);
    w2.displayS(Vmax, 0);
        w3.displayS(Vmax, 0);
    w4.displayS(Vmax, 0);
    w5.displayS(Vmax, 0);
        w6.displayS(Vmax, 0);
    w7.displayS(Vmax, 0);

  } else {
  }

  // V boxを表示する。ifの中に書く
  stroke(0);
  if (VtoggleValue) {

    w7.displayV(backFlag);
    w6.displayV(backFlag); 
    w5.displayV(backFlag);
    w4.displayV(backFlag);  
        w3.displayV(backFlag);    
    w2.displayV(backFlag);
    w1.displayV(backFlag);
  }
}
//**************************************************************************************


//****************オブジェクトの定義はここから下で*****************//
//変更は不要！
//ワイヤーオブジェクトを手動で継承

//***初期化
//**WireObj(始点x,始点y,線の長さ,角度,入力電圧、出力電圧、向き)
//**RObj(始点x,始点y,線の長さ,角度,入力電圧、出力電圧、向き)
//**BatObj(始点x,始点y,線の長さ,角度,入力電圧、出力電圧、向き)

//メソッド
//.displayC(); 回路を描画
//.displyS(Vmax,Vmin);目盛りを表示　引数は、縦軸の上限
//.displayV(); グラフを描画　
//     まだ、縦軸をマイナスの方向には拡張できていないです。

class WireObj {
  float x1, y1;
  float L, deg;
  float Vin, Vout;
  String Muki; 

  float endX = 0;
  float  endY = 0;

  WireObj(float tempX, float tempY, float tempL, float tempDeg, float tempVin, float tempVout, String tempMuki) {
    x1 = tempX;
    y1 = tempY;
    L = tempL;
    deg = tempDeg;
    Vin = tempVin;
    Vout = tempVout;
    Muki = tempMuki;


    if (Muki == "U") {
      endX = x1 + L  * cos(deg);
      endY = y1 - L * sin(deg);
    } else if (Muki == "R") {
      endX = x1 + L;
      endY = y1;
    } else if (Muki == "L") {
      endX = x1 - L;
      endY = y1;
    } else if (Muki == "D") {
      endX = x1 - L  * cos(deg);
      endY = y1 + L * sin(deg);
    }
  }

  void displayC() { //回路の表示メソッド
    stroke(0);
    line(x1, y1, endX, endY); 
    pushStyle();
    strokeWeight(memoriWeight);
    ellipse(x1, y1, 10, 10);
    popStyle();
  }
  void displayV(boolean flag) {//グラフを表示するメソッド //グラフの縦軸の幅はVmaxで取得
    pushStyle();
    noStroke();
    fill(118, 236, 255, 128);
    quad(
      x1, y1, 
      endX, endY, 
      endX, endY- Vin, 
      x1, y1-Vin
      );
    popStyle();


    //電圧を作図する
    pushStyle(); 
    stroke(#051BFA);
    strokeWeight(graphWeight);
    line(x1, y1 - Vin, endX, endY - Vin);
    popStyle();
  }

  void displayS(float Vmax, float Vmin) {
    //電圧のメモリ
    pushStyle(); 
    strokeWeight(memoriWeight);
    line(x1, y1 - Vmax, x1, y1 + Vmin);
    for (int i = 1; i <= Vmax / 10; i++) {//Vinの目盛り
      line(x1 - 5, y1 - i  * 10, x1 + 5, y1 - i  * 10);
    }
    popStyle();
  }
}



class RObj {
  float x1, y1;
  float L, deg;
  float Vin, Vout;
  String Muki; //ワイヤーの向き　１；縦　０；横

  float endX = 0;
  float  endY = 0;

  //R抵抗の作図用
  float rWidHi = 2; //Rの幅をワイヤーの長さLに対してどんな比にするか
  float rHeight = 10;

  RObj(float tempX, float tempY, float tempL, float tempDeg, float tempVin, float tempVout, String tempMuki) {
    x1 = tempX;
    y1 = tempY;
    L = tempL;
    deg = tempDeg;
    Vin = tempVin;
    Vout = tempVout;
    Vout = tempVout;
    Muki = tempMuki;

    if (Muki == "U") {
      endX = x1 + L  * cos(deg);
      endY = y1 - L * sin(deg);
    } else if (Muki == "R") {
      endX = x1 + L;
      endY = y1;
    } else if (Muki == "L") {
      endX = x1 - L;
      endY = y1;
    } else if (Muki == "D") {
      endX = x1 - L  * cos(deg);
      endY = y1 + L * sin(deg);
    }
  }

  void displayC() { //回路の表示メソッド
    stroke(0);
    line(x1, y1, endX, endY); 
    float rWidth = L / rWidHi;

    //回路の描画
    //縦か横で場合分け
    if (Muki == "U" || Muki == "D") {
      quad(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  + rHeight, endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi), 
        endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  - rHeight, endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi), 
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) - rHeight, y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi), 
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) + rHeight, y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) 
        );
    } else {
      quad(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) + rHeight, 
        endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) -  rHeight, 
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - rHeight, 
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) + rHeight
        );
    }
    pushStyle();
    strokeWeight(memoriWeight);
    ellipse(x1, y1, 10, 10);
    popStyle();
  }

  void displayV(boolean flag) {//グラフを表示するメソッド //グラフの縦軸の幅はVmaxで取得
    if (flag == true) {
      pushStyle();
      noStroke();
      fill(118, 236, 255, 128);
      quad(
        x1, y1, 
        endX, endY, 
        endX, endY- Vout, 
        x1, y1-Vout
        );
      quad(
        x1, y1 - Vin, 
        endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - Vin, 
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - Vout, 
        x1, y1-Vout
        );
      popStyle();
    }

    //電圧を作図する
    pushStyle();
    stroke(#051BFA);
    strokeWeight(graphWeight);
    line(x1, y1 - Vin, 
      endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - Vin);
    line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - Vin, 
      x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - Vout);
    line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - Vout, 
      endX, endY - Vout);
    popStyle();
  }

  void displayS(float Vmax, float Vmin) {  
    //縦軸を描画
    //線の幅memoriWeight は、グローバル変数で定義
    stroke(0);
    pushStyle(); 
    strokeWeight(memoriWeight);

    //銅線の縦軸
    line(x1, y1 - Vmax, x1, y1 + Vmin);
    // 抵抗の縦軸
    line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - Vmax, 
      endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi), endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) + Vmin
      );
    //銅線の縦軸
    line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi)  - Vmax, 
      x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi), y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) + Vmin
      );

    for (int i = 1; i <= Vmax / 10; i++) {//Vinの目盛り
      line(x1 - 5, y1 - i  * 10, x1 + 5, y1 - i  * 10);
    }

    if (Muki == "R" || Muki == "L") { // //抵抗前の目盛り
      for (int i = 1; i <= Vmax / 10; i++) {
        line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) - 5, 
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - i  * 10, 
          endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) + 5, 
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - i  * 10);
      }
    } else {
      for (int i = 1; i <= Vmax / 10; i ++) {
        line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  - 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - i * 10, 
          endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) + 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i * 10
          );
      }
    }
    if (Muki == "R" || Muki == "L") { // //抵抗後の目盛り
      for (int i = 1; i <= Vmax / 10; i++) {
        line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) - 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i  * 10, 
          x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) + 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i  * 10);
      }
    } else {
      for (int i = 1; i <= Vmax / 10; i ++) {
        line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi)  - 5, 
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi)  - i * 10, 
          x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) + 5, 
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - i * 10
          );
      }
    }
    popStyle();
  }
}



class BatObj {
  float x1, y1;
  float L, deg;
  float Vin, Vout;
  String Muki; //ワイヤーの向き　１；縦　０；横

  float endX = 0;
  float  endY = 0;

  //R抵抗の作図用
  float batWidHi = 10; //Vの幅をワイヤーの長さLに対してどんな比にするか
  float rHeight = 20;

  BatObj(float tempX, float tempY, float tempL, float tempDeg, float tempVin, float tempVout, String tempMuki) {
    x1 = tempX;
    y1 = tempY;
    L = tempL;
    deg = tempDeg;
    Vin = tempVin;
    Vout = tempVout;
    Vout = tempVout;
    Muki = tempMuki;

    if (Muki == "U") {
      endX = x1 + L  * cos(deg);
      endY = y1 - L * sin(deg);
    } else if (Muki == "R") {
      endX = x1 + L;
      endY = y1;
    } else if (Muki == "L") {
      endX = x1 - L;
      endY = y1;
    } else if (Muki == "D") {
      endX = x1 - L  * cos(deg);
      endY = y1 + L * sin(deg);
    }
  }

  void displayC() { //回路の表示メソッド
    stroke(0);
    line(x1, y1, endX, endY); 
    stroke(255);  
    //縦か横で場合分け
    if (Muki == "U" || Muki == "D") {
      quad(endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi)  + rHeight, endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi), 
        endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi)  - rHeight, endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi), 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi) - rHeight, y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi), 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi) + rHeight, y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi) 
        );
    } else {
      quad(endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi), endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi) + rHeight, 
        endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi), endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi) -  rHeight, 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi), y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi) - rHeight, 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi), y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi) + rHeight
        );
    }
    stroke(0);

    //電源の両端の棒
    float Vmax = 30;
    if (Muki == "R" || Muki == "L") { // //抵抗前の目盛り

      //-
      line(endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi), endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi)  - Vmax / 2, 
        endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi), endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi) + Vmax / 2
        );
      //+
      line(x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi), y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi)  - Vmax, 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi), y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi) + Vmax
        );
    } else {
      line(endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi) - Vmax / 2, 
        endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi), 
        endX * (batWidHi - 1) / (2 * batWidHi)   +   x1 * (batWidHi + 1) / (2 * batWidHi) + Vmax / 2, 
        endY * (batWidHi - 1) / (2 * batWidHi)   +   y1 * (batWidHi + 1) / (2 * batWidHi));

      line(x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi) - Vmax, 
        y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi), 
        x1 * (batWidHi - 1) / (2 * batWidHi)   +   endX * (batWidHi + 1) / (2 * batWidHi) + Vmax, 
        y1 * (batWidHi - 1) / (2 * batWidHi)   +   endY * (batWidHi + 1) / (2 * batWidHi));
    }

    pushStyle();
    strokeWeight(memoriWeight);
    ellipse(x1, y1, 10, 10);
    popStyle();
  }

  void displayV(boolean flag) {//グラフを表示するメソッド //グラフの縦軸の幅はVmaxで取得
    //重なり愛の関係で、先に色から作図
    if (flag == true) {
      pushStyle();
      noStroke();
      fill(118, 236, 255, 128);
      quad(
        x1, y1, 
        (endX    +   x1) / 2, (endY    +   y1) / 2, 
        (endX    +   x1) / 2, (endY    +   y1) / 2 - Vin, 
        x1, y1-Vin
        );

      quad(
        (endX    +   x1) / 2, (endY    +   y1) / 2, 
        endX, endY, 
        endX, endY -Vout, 
        (endX    +   x1) / 2, (endY    +   y1) / 2 - Vout
        );
      popStyle();

      //電圧を作図する
      pushStyle();
      strokeWeight(graphWeight);
      stroke(#051BFA);
      line(x1, y1 - Vin, 
        (endX    +   x1) / 2, (endY    +   y1) / 2 - Vin);
      line((endX    +   x1) / 2, (endY    +   y1) / 2 - Vin, 
        (endX    +   x1) / 2, (endY    +   y1) / 2 - Vout);
      line((endX    +   x1) / 2, (endY    +   y1) / 2 - Vout, 
        endX, endY - Vout);
      popStyle();
    }
  }

  void displayS(float Vmax, float Vmin) {  
    //縦軸を描画
    //線の幅memoriWeight は、グローバル変数で定義
    stroke(0);
    pushStyle(); 
    strokeWeight(memoriWeight);

    //銅線の縦軸
    line(x1, y1 - Vmax, x1, y1 + Vmin);
    // 電源の縦軸
    line((endX    +   x1) / 2, (endY    +   y1) / 2 - Vmax, 
      (endX    +   x1) / 2, (endY    +   y1) / 2 - Vmin
      );


    for (int i = 1; i <= Vmax / 10; i++) {//Vinの目盛り
      line(x1 - 5, y1 - i  * 10, x1 + 5, y1 - i  * 10);
    }

    for (int i = 1; i <= Vmax / 10; i++) {//Vinの目盛り
      line((endX    +   x1) / 2  - 5, (endY    +   y1) / 2 - i  * 10, (endX    +   x1) / 2   + 5, (endY    +   y1) / 2  - i  * 10);
    }

    popStyle();
  }
}

void mousePressed() {
  int tmpVX = (int)(sizeW * VtoggleX);
  int tmpVY = (int)(sizeH * controlY);
  int tmpSX = (int)(sizeW * StoggleX);
  int tmpSY = (int)(sizeH * controlY);
  float dV = dist(mouseX, mouseY, tmpVX, tmpVY);
  float dS = dist(mouseX, mouseY, tmpSX, tmpSY);
  if (dV < bottunSize) {  
    toggleV();
  }
  if (dS < bottunSize) {  
    toggleS();
  }

}

void toggleV() {
  if (VtoggleValue) {
    VtoggleValue =  false;       // Boolean.valueOf(false);
  } else {
    VtoggleValue =  true;          //Boolean.valueOf(true);
  }
}

void toggleS() {
  if (StoggleValue) {
    StoggleValue =  false;       // Boolean.valueOf(false);
  } else {
    StoggleValue =  true;          //Boolean.valueOf(true);
  }
}
