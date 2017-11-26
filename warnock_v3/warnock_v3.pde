//Jaime Andres Vargas Arevalo 
//National University from Colombia
//Github: https://github.com/jaavargasar
//Webpage: https://jaavargasar.github.io/
//Code: https://github.com/jaavargasar/jaavargasar.github.io/tree/master/warnock_v3

import java.util.*;


//Global Variables
final float ADD=200;
final double EPS = 1e-9;
final int END=4;

boolean matrix[][][]= new boolean[451][351][350]; //check depth of a pixel
ArrayList< List<point> > polygons =new ArrayList< List<point> >(); //List of polygons

//Arrays of Colors
ArrayList<Float> coldx = new ArrayList<Float>(); 
ArrayList<Float> coldy = new ArrayList<Float>();
ArrayList<Float> coldz = new ArrayList<Float>();


void setup() {
  size(901, 700);
  background(250);
  
  addLines(); //Add initial and central red lines

  addRandomPolygons(); //Add rectangles random
  loadPixels();
  
  
  warnockAlgorithm(0,351,451,0,0);
  addFaceSide();
  addFaceUp();
  addFaceDown();
  println("end of program");
 
}

//Show Face down of the scene
void addFaceDown(){
  pushStyle();
  int cnt=0;
  
  for( List<point> A: polygons){
     
     float x=(float) A.get(0).getX();
     float  lng = (float) A.get(2).getX();
     float z= (float) A.get(0).getZ();
    
     color c = color( coldx.get(cnt),coldy.get(cnt),coldz.get(cnt) );
     stroke( c );
     strokeWeight(4);  // Thicker
     
     line(x+450,z+350,lng+450,z+350);
     cnt++;
    
  }
  popStyle();
  
  
}

//show face up of the scene
void addFaceUp(){
  pushStyle();
  int cnt=0;
  
  for( List<point> A: polygons){
     
     float x=(float) A.get(0).getX();
     float  lng = (float) A.get(2).getX();
     float z= (float) A.get(0).getZ();
    
     color c = color( coldx.get(cnt),coldy.get(cnt),coldz.get(cnt) );
     stroke( c );
     strokeWeight(4);  // Thicker
     
     line(x+450,350-z,lng+450,350-z);
     cnt++;
    
  }
  popStyle();
  
  
}


//show face of the right side of the scene
void addFaceSide(){
  pushStyle();
  int cnt=0;
  
  for( List<point> A: polygons){
     
     float y=(float) A.get(0).getY();
     float  lng = (float) A.get(2).getY();
     float z= (float) A.get(0).getZ();
    
     color c = color( coldx.get(cnt),coldy.get(cnt),coldz.get(cnt) );
     stroke( c );
     strokeWeight(4);  // Thicker
     line(z,y+350,z,lng+350);
     cnt++;
    
  }
  popStyle();
  
}

//Add initial and central red lines
void addLines(){
  
 pushStyle();
 stroke(204, 102, 0);
 int x1=0,y1=700,x2=900,y2=0;
 line( x2+(y2-x2)/2, x1, x2+(y2-x2)/2, y1);
 line(x2, x1+(y1-x1)/2, y2, x1+(y1-x1)/2 );
 
 popStyle();
  
}


//Add Random rectangles in any position (x,y,z)
void addRandomPolygons(){
  pushStyle();
  noStroke();
  
   
   int many=(int)random(3,5);
   List<point> P;
   
   float z=350;
   
   for(int times=0;times<many;times++){
   
  
     P = new ArrayList<point>();
   
     float x,y,w,h;
     
     x=random(300);
     y=random(200);
     w=random(50,150);
     h=random(50,150);
     z-=45;
     
     
     P.add( new point(x,y,z) );
     P.add( new point(x+w,y,z) );
     P.add( new point(x+w,y+h,z) );
     P.add( new point(x,y+h,z) );
     P.add(P.get(0)); // loop back
     polygons.add( P);
     
     float coli=random(5,255), colj=random(5,255), colk=random(5,255);
     fill( coli,colj,colk );
     coldx.add(coli); coldy.add(colj); coldz.add(colk);

     rect(x,y,w,h);
   
   }
   //special case
   //stroke(1);
   P = new ArrayList<point>();
   double x=polygons.get(0).get(0).getX()+30;
   double y=polygons.get(0).get(0).getY()+30;
   z=100;
   float w=random(50,115);
   float h=random(50,100);
     
   P.add( new point(x,y,z) );
   P.add( new point(x+w,y,z) );
   P.add( new point(x+w,y+h,z) );
   P.add( new point(x,y+h,z) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
     
   float coli=random(5,255), colj=random(5,255), colk=random(5,255);
   fill( coli,colj,colk );
   coldx.add(coli); coldy.add(colj); coldz.add(colk);
   rect((float )x,(float )y,w,h);
   
   
   popStyle();
  
}

//Proof of a static scene
void addPolygons(){
   
   pushStyle();
   noStroke();
   
   
   
   List<point> P;
   
   P = new ArrayList<point>();
   
   P.add( new point(100,50,5) );
   P.add( new point(300,50,5) );
   P.add( new point(300,150,5) );
   P.add( new point(100,150,5) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
   
   fill(#FFFF00);
   rect(100,50,200,100);
   
  
   
   P = new ArrayList<point>();
   
   
   P.add( new point(135,98,1) );
   P.add( new point(335,98,1) );
   P.add( new point(335,198,1) );
   P.add( new point(135,198,1) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
   
   fill(#FF0000); 
   rect(135,98,200,100);
   
   popStyle();
}

//Clear if a pixel was check already
void clearingMatrix(){
   for(int i=0;i<450;i++)
     for(int j=0;j<350;j++)
        for(int z=0;z<350;z++)
          matrix[i][j][z]=false;
  
  
}


//WARNOCK ALGORITHM
void warnockAlgorithm(int x1,int y1,int y2, int x2,int times){
  
  if( times==END) return;
  HashSet< List<point> > oncePolygons = new HashSet<List<point> >( );
  clearingMatrix();
  
  int counter=0;
  int iniPixel= x2 + x1*450;
  if( iniPixel>=450*350) iniPixel=450*350 -1 ; 
 
  
  for ( int y = y1-1; y >=x1; y--) { //height
    for ( int x = y2-1; x >= x2; x--) { //width
              
      
      for( List<point> A: polygons) { // all A in polygons
        
        if( inPolygon( new point(x,y,A.get(0).getZ() ), A) ){ // (x,y) in A ?
          
          //println(x,y,(int)A.get(0).getZ() );
          matrix[x][y][(int)A.get(0).getZ()] =true;
          oncePolygons.add( A );  // check A in oncePolygons
           //if( !checkIfListinside( oncePolygons, A ) ) oncePolygons.add( A );   
        }
      
        
      }
    }
 
  }
  
  counter= oncePolygons.size();
  
  if( counter == 0 ) return;
  if( counter == 1) return;
  if( checkAllInside(x1,y1,y2,x2,oncePolygons ) ) return;
  
 
  
  //println( "after "+oncePolygons.size()+", de"+y1+" hasta"+x1+", y de"+y2+" hasta"+x2 );
  println("loading... ");
  
    

  line( x2+(y2-x2)/2, x1, x2+(y2-x2)/2, y1);
  line(x2, x1+(y1-x1)/2, y2, x1+(y1-x1)/2 );
           
  warnockAlgorithm( x1+(y1-x1)/2,y1,y2,x2+(y2-x2)/2,times+1);
  warnockAlgorithm( x1,x1+(y1-x1)/2,y2,x2+(y2-x2)/2,times+1);
  warnockAlgorithm(x1,x1+(y1-x1)/2,x2+(y2-x2)/2,x2,times+1);
  warnockAlgorithm(x1+(y1-x1)/2,y1,x2+(y2-x2)/2,x2,times+1);
  return;
  
}

//Z Case: check the depth of the rectangles and which one is over who
boolean checkAllInside(int x1,int y1,int y2, int x2,HashSet< List<point> > OP ){
  
    int min=100;
    
    for( List<point> A: OP)
       min = min( min, (int) A.get(0).getZ() ); 
    

    boolean checking=true;
    for ( int y = y1-1; y >=x1; y--) { //height
      for ( int x = y2-1; x >= x2; x--) { //width
         checking &= matrix[x][y][min];
      }
    }
   
    return checking;
}


//Check if a polygon is already inside List of polygons
boolean checkPolInside(int x1,int y1,int y2,int x2){
  
  int count=0;
  for ( int y = y1-1; y >=x1; y--) { //height
      for ( int x = y2-1; x >= x2; x--) { //width
         for( List<point> A: polygons){
            if( matrix[x][y][(int) A.get(0).getZ() ] ){
               count++;
               break;
            }
         }
      
      }
    }
    
    if( ( y1-1-x1 * y2-1-x2) ==count) return true;
    return false;
}




//Check if a list of points is inside a polygon
boolean checkIfListinside(  HashSet< List<point> > A, List<point> B){
  int count=0;
  
  for( List<point> list: A){
     for(int i=0;i<list.size();i++){
         if( Math.abs( list.get(i).getX() - B.get(i).getX() ) < EPS )
           count++;
           
         if( Math.abs( list.get(i).getY() - B.get(i).getY() ) < EPS )
           count++;
     }
     if( count==6) return true;
     count=0;
  }
  return false;
  
}


// returns true if a point is inside a convex polygon
boolean inPolygon(point pt, List<point> P) {
    
    if ((int)P.size() == 0) return false;
    
    double sum = 0; 
    
    for (int i = 0; i < (int)P.size()-1; i++) {
      
      if (checkingPointsAndSides(pt, P.get(i), P.get(i+1)))
        sum += angle(P.get(i), pt, P.get(i+1));  
      
      else 
        sum -= angle(P.get(i), pt, P.get(i+1)); 
      
    } 
    
    return Math.abs(Math.abs(sum) - 2*Math.PI) < EPS; 

}



// returns true if point r is on the left side of line pq
boolean checkingPointsAndSides(point p, point q, point r) {
  
  return ( cross(toVec(p, q), toVec(p, r)) >=0 || collinear(p,q,r) );
}        

//check case collinear points
boolean collinear(point p, point q, point r) {
  return Math.abs(cross(toVec(p, q), toVec(p, r))) < EPS; 
}
      
      
//return a vector of P(a,b)
vec toVec(point a, point b) {            
   return new vec(b.x - a.x, b.y - a.y); 
}
      
//cross product
double cross(vec a, vec b) { 
  return a.x * b.y - a.y * b.x; 
}


//return angle of vector(a,o,b)
double angle(point a, point o, point b) {     
   vec oa = toVec(o, a), ob = toVec(o, b);
      
   return Math.acos(dot(oa, ob) / Math.sqrt(normDistance(oa) * normDistance(ob))); 
}
   
      
//DOT product
double dot(vec a, vec b) { 
  return (a.x * b.x + a.y * b.y); 
}

//norm of a vector
double normDistance(vec v) { 
  return v.x * v.x + v.y * v.y; 
}