//Jaime Andres Vargas Arevalo 

import java.util.*;

void setup() {
  size(600, 600);
  background(250);
  createPicture1();
  //createPicture2();
  loadPixels();
  //warnockAlgorithm(0,height,width,0);
 
}

void createPicture1(){
  pushStyle();
  noStroke();
  fill(#FFFF00);//yellow color
  rect(104,82,100,100);
  rect(400,422,100,100);
  fill(#FF0000); //red color
  rect(350,82,100,100);
  rect(104+60,82+45,100,100);
  popStyle();
 
}

void createPicture2(){
 
  pushStyle();
  strokeWeight(4);
  fill(#008000); //green color
  triangle(142,82,142+200,82+60,142-20,82+100);
  noStroke();
  fill(#008080);//teal color
  rect(150+62,82+150,200,100);
  fill(#FF00FF);
  ellipse(150+62+150,82+150+50,100,100);
  fill(#FFFF00);
  rect(300,450,50,110);
  popStyle();
  
  pushStyle();
  fill(#FFFF00);
  strokeWeight(4);
  rect(300-100,450,50,110);
  popStyle();
  
}

void warnockAlgorithm(int x1,int y1,int y2, int x2){

  HashSet<Object> colors = new HashSet<Object>();
  int counter=0;
  
  int iniPixel= x2 + x1*width;
  if( iniPixel>=360000) iniPixel=359999; 
  
  Object pix=pixels[iniPixel];
  colors.add(pix);
  
  for ( int y = y1-1; y >=x1; y--) { //height
    for ( int x = y2-1; x >= x2; x--) { //width
       int loc = x + y*width;
      
      //si no lo contiene lo agrega y cuenta
      if( check(pixels[loc], colors) ){  colors.add(pixels[loc]);   }
     
    }
    
  }
  
  counter= colors.size();
  
  if( counter>2){
      //strokeWeight(2);
      line( x2+(y2-x2)/2, x1, x2+(y2-x2)/2, y1);
      line(x2, x1+(y1-x1)/2, y2, x1+(y1-x1)/2 );
           
      warnockAlgorithm( x1+(y1-x1)/2,y1,y2,x2+(y2-x2)/2);
      warnockAlgorithm( x1,x1+(y1-x1)/2,y2,x2+(y2-x2)/2);
      warnockAlgorithm(x1,x1+(y1-x1)/2,x2+(y2-x2)/2,x2);
      warnockAlgorithm(x1+(y1-x1)/2,y1,x2+(y2-x2)/2,x2);

  }

  return;
}



boolean check(Object pix,HashSet colors){
  if( colors.contains(pix) ) return false; //si ya lo contiene
  return true;                             //si no lo contiene
}