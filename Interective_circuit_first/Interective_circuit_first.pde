WireObj w1;
RObj w2;
RObj w3;
WireObj w4;

int memoriWeight = 1;

void setup() {
  size(480,480);
  background(255);
  smooth();
  strokeWeight(5);
  
  float x1 = 100; 
  float y1 = 300;
  float L = 200;
  float deg = radians(60); //0度〜180度で指定
  float Vin = 80;
  float V1 = 40;
  float Gnd  = 0;
   
  
  w1 = new WireObj(x1,y1,L,deg,Vin, Vin, "R");
  w2 = new RObj(w1.endX,w1.endY,L,deg,w1.Vout,V1,"U");
  w3 = new RObj(w2.endX,w2.endY,L,deg,w2.Vout,Gnd,"L");
  w4 = new WireObj(w3.endX,w3.endY,L,deg,Gnd,Gnd,"D");
}

void draw() {
  float Vmax = 80;
  w1.displayC();
  w1.displayV(Vmax,0);
  w2.displayC();
  w2.displayV(Vmax,0);
  w3.displayC();
  w3.displayV(Vmax,0);
  w4.displayC();
  w4.displayV(Vmax,0);
}



//****************オブジェクトの定義はここから下で*****************//
//ワイヤーオブジェクトを手動で継承

//***初期化
//**WireObj(始点x,始点y,線の長さ,角度,入力電圧、出力電圧、向き)
//**RObj(始点x,始点y,線の長さ,角度,入力電圧、出力電圧、向き)
//

//メソッド
//.displayC(); 回路を描画
//.displayV(Vmax,Vmin); グラフを描画　引数は、縦軸の上限
//     まだ、縦軸をマイナスの方向には拡張できていないです。

class WireObj{
  float x1 , y1;
  float L,deg;
  float Vin,Vout;
  String Muki; //ワイヤーの向き　１；縦　０；横
  
  float endX = 0;
  float  endY = 0;
  
  WireObj(float tempX,float tempY, float tempL ,float tempDeg , float tempVin, float tempVout ,String tempMuki) {
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
    } 
    else if (Muki == "R") {
      endX = x1 + L;
      endY = y1;
    }
    else if (Muki == "L") {
      endX = x1 - L;
      endY = y1;
    }
    else if (Muki == "D") {
      endX = x1 - L  * cos(deg);
      endY = y1 + L * sin(deg);
    } 
  }
  
  void displayC() { //回路の表示メソッド
    stroke(0);
    line(x1,y1,endX,endY); 
    pushStyle();
    strokeWeight(memoriWeight);
    ellipse(x1,y1,10,10);
    popStyle();
  }
  void displayV(float Vmax , float Vmin) {//グラフを表示するメソッド //グラフの縦軸の幅はVmaxで取得
    //電圧を作図する
    stroke(#051BFA);
    line(x1,y1 - Vin ,endX,endY - Vin);
    stroke(0);
    
    //電圧のメモリ
    pushStyle(); 
    strokeWeight(memoriWeight);
    line(x1,y1 - Vmax,x1,y1 + Vmin);
    for (int i = 1;i <= Vmax / 10;i++) {//Vinの目盛り
      line(x1 - 5, y1 - i  * 10 , x1 + 5 , y1 - i  * 10);
    }
    popStyle();
  }
}




class RObj{
  float x1 , y1;
  float L,deg;
  float Vin,Vout;
  String Muki; //ワイヤーの向き　１；縦　０；横
  
  float endX = 0;
  float  endY = 0;
  
  //R抵抗の作図用
  float rWidHi = 3; //Rの幅をワイヤーの長さLに対してどんな比にするか
  float rHeight = 10;
  
  RObj(float tempX,float tempY, float tempL ,float tempDeg , float tempVin,  float tempVout ,String tempMuki) {
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
    } 
    else if (Muki == "R") {
      endX = x1 + L;
      endY = y1;
    }
    else if (Muki == "L") {
      endX = x1 - L;
      endY = y1;
    }
    else if (Muki == "D") {
      endX = x1 - L  * cos(deg);
      endY = y1 + L * sin(deg);
    } 
  }
  
  void displayC() { //回路の表示メソッド
    stroke(0);
    line(x1,y1,endX,endY); 
    float rWidth = L / rWidHi;
    
    //縦か横で場合分け
    if (Muki == "U" || Muki == "D") {
      quad(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  + rHeight,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) ,
        endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  - rHeight ,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) ,
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) - rHeight ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) ,
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) + rHeight ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) 
     );} else {
      quad(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  ,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) + rHeight ,
        endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)   ,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) -  rHeight,
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi)  ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - rHeight,
        x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi)  ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) + rHeight
       );
    }
    pushStyle();
    strokeWeight(memoriWeight);
    ellipse(x1,y1,10,10);
    popStyle();
  }
  
  void displayV(float Vmax , float Vmin) {//グラフを表示するメソッド //グラフの縦軸の幅はVmaxで取得
    //電圧を作図する
    stroke(#051BFA);
    line(x1,y1 - Vin ,
      endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)   ,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - Vin);
    line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)   ,endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - Vin ,
      x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi)   ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - Vout);
    line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi)  ,y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - Vout ,
      endX ,endY - Vout);
    
    //縦軸を描画
    //線の幅memoriWeight は、グローバル変数で定義
    stroke(0);
    pushStyle(); 
    strokeWeight(memoriWeight);
    
    //銅線の縦軸
    line(x1,y1 - Vmax,x1,y1 + Vmin);
    // 抵抗の縦軸
    line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) , endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - Vmax,
      endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) , endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) + Vmin
     );
    //銅線の縦軸
    line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) , y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi)  - Vmax,
      x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) , y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) + Vmin
     );
    
    for (int i = 1;i <= Vmax / 10;i++) {//Vinの目盛り
      line(x1 - 5, y1 - i  * 10 , x1 + 5 , y1 - i  * 10);
    }
    
    if (Muki == "R" || Muki == "L") { // //抵抗前の目盛り
      for (int i = 1;i <= Vmax / 10;i++) {
        line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) - 5, 
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - i  * 10 ,
          endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) + 5 ,
          y1 * (rWidHi - 1) / (2 * rWidHi)   +   endY * (rWidHi + 1) / (2 * rWidHi) - i  * 10);
      }
    } else {
      for (int i = 1;i <= Vmax / 10;i ++) {
        line(endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi)  - 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi)  - i * 10,
          endX * (rWidHi - 1) / (2 * rWidHi)   +   x1 * (rWidHi + 1) / (2 * rWidHi) + 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i * 10
         );
      }
    }
    if (Muki == "R" || Muki == "L") { // //抵抗後の目盛り
      for (int i = 1;i <= Vmax / 10;i++) {
        line(x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) - 5, 
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i  * 10 ,
          x1 * (rWidHi - 1) / (2 * rWidHi)   +   endX * (rWidHi + 1) / (2 * rWidHi) + 5 ,
          endY * (rWidHi - 1) / (2 * rWidHi)   +   y1 * (rWidHi + 1) / (2 * rWidHi) - i  * 10);
      }
    } else {
      for (int i = 1;i <= Vmax / 10;i ++) {
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
