//Jaime Andres Vargas Arevalo 

import java.util.*;


final float ADD=200;
final double EPS = 1e-9;
//HashSet< ArrayList<point> > polygons = new HashSet<ArrayList<point> >( );

float witdhRec = 200;
float heightRec =100;
boolean matrix[][][]= new boolean[601][601][51];


ArrayList< List<point> > polygons =new ArrayList< List<point> >();

void setup() {
  size(600, 600);
  background(250);

  createPicture3();
  loadPixels();
  addPolygons();
  warnockAlgorithm(0,height,width,0);
  //probando();
  println("end of program");
 
}



void printPolygons(){
  println("inside printing polygons");
  addPolygons();
  //for( List<point> A: polygons){
  //   for(int i=0;i<A.size();i++) println( A.get(i).getX()+" "+A.get(i).getY());
  //   println();
  //}
  for(int i=0;i< polygons.get(0).size(); i++)
    println( polygons.get(0).get(i).getX()+" "+polygons.get(0).get(i).getY());
}

void createPicture3(){
  pushStyle();
  noStroke();
  fill(#FFFF00);//yellow color
  
  //triangle(100,120,150,50,300,120);
  rect(100,50,200,100);
  
  
  //fill(#FF0000); //red color
  //triangle(100+ADD,100+ADD, 200+ADD,50+ADD,300+ADD,120+ADD);
  
  
  fill(#FF0000); //red color
  //triangle(100,50,220,380,300,120);
  rect(135,98,200,100);
  popStyle();
}
  

void addPolygons(){
 
   List<point> P;
   
   P = new ArrayList<point>();
   
   P.add( new point(100,50,5) );
   P.add( new point(300,50,5) );
   P.add( new point(300,150,5) );
   P.add( new point(100,150,5) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
   
  
  
   P = new ArrayList<point>();
   
   
   P.add( new point(135,98,1) );
   P.add( new point(335,98,1) );
   P.add( new point(335,198,1) );
   P.add( new point(135,198,1) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
}

void clearingMatrix(){
   for(int i=0;i<601;i++)
     for(int j=0;j<601;j++)
        for(int z=0;z<51;z++)
          matrix[i][j][z]=false;
  
  
}


void warnockAlgorithm(int x1,int y1,int y2, int x2){
  
  HashSet< List<point> > oncePolygons = new HashSet<List<point> >( );
  clearingMatrix();
  
  int counter=0;
  boolean isInsideAPolygon=false;
  
  int iniPixel= x2 + x1*width;
  if( iniPixel>=360000) iniPixel=359999; 
 
  
  for ( int y = y1-1; y >=x1; y--) { //height
    for ( int x = y2-1; x >= x2; x--) { //width
              
      
      for( List<point> A: polygons) { // all A in polygons
        
        if( inPolygon( new point(x,y,A.get(0).getZ() ), A) ){ // (x,y) in A ?
          
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
  if( checkAllInside(x1,y1,y2,x2 ) ) return;
  
  //println( "after "+oncePolygons.size()+", de"+y1+" hasta"+x1+", y de"+y2+" hasta"+x2 );
  println("loading...");
  
    

  line( x2+(y2-x2)/2, x1, x2+(y2-x2)/2, y1);
  line(x2, x1+(y1-x1)/2, y2, x1+(y1-x1)/2 );
           
  warnockAlgorithm( x1+(y1-x1)/2,y1,y2,x2+(y2-x2)/2);
  warnockAlgorithm( x1,x1+(y1-x1)/2,y2,x2+(y2-x2)/2);
  warnockAlgorithm(x1,x1+(y1-x1)/2,x2+(y2-x2)/2,x2);
  warnockAlgorithm(x1+(y1-x1)/2,y1,x2+(y2-x2)/2,x2);
  return;
  
}



boolean checkAllInside(int x1,int y1,int y2, int x2 ){
  
    int min=100;
    
    for( List<point> A: polygons)
       min = min( min, (int) A.get(0).getZ() ); 
    

    boolean checking=true;
    for ( int y = y1-1; y >=x1; y--) { //height
      for ( int x = y2-1; x >= x2; x--) { //width
         checking &= matrix[x][y][min];
      }
    }
   
    return checking;
}



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


// returns true if point p is in either convex/concave polygon P

boolean inPolygon(point pt, List<point> P) {
    
    if ((int)P.size() == 0) return false;
    
    double sum = 0; // assume first vertex = last vertex
    
    for (int i = 0; i < (int)P.size()-1; i++) {
      
      if (ccw(pt, P.get(i), P.get(i+1)))
        sum += angle(P.get(i), pt, P.get(i+1));   // left turn/ccw
      
      else 
        sum -= angle(P.get(i), pt, P.get(i+1)); 
      
    } // right turn/cw
    
    return Math.abs(Math.abs(sum) - 2*Math.PI) < EPS; 

}


// note: to accept collinear points, we have to change the `> 0'
    // returns true if point r is on the left side of line pq
boolean ccw(point p, point q, point r) {
  
  return ( cross(toVec(p, q), toVec(p, r)) >0 || collinear(p,q,r) );
}          // this polygon is convex

boolean collinear(point p, point q, point r) {
      return Math.abs(cross(toVec(p, q), toVec(p, r))) < EPS; }
      
vec toVec(point a, point b) {               // convert 2 points to vector
   return new vec(b.x - a.x, b.y - a.y); 
}
      
      
double cross(vec a, vec b) { 
  return a.x * b.y - a.y * b.x; 
}


double angle(point a, point o, point b) {     // returns angle aob in rad
   vec oa = toVec(o, a), ob = toVec(o, b);
      
   return Math.acos(dot(oa, ob) / Math.sqrt(norm_sq(oa) * norm_sq(ob))); 
}
      
double dot(vec a, vec b) { 
  return (a.x * b.x + a.y * b.y); 
}


double norm_sq(vec v) { 
  return v.x * v.x + v.y * v.y; 
}