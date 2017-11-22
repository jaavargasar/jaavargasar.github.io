//Jaime Andres Vargas Arevalo 

import java.util.*;


final float ADD=200;
final double EPS = 1e-9;
//HashSet< ArrayList<point> > polygons = new HashSet<ArrayList<point> >( );

ArrayList< List<point> > polygons =new ArrayList< List<point> >();

void setup() {
  size(600, 600);
  background(250);

  createPicture3();
  loadPixels();
  addPolygons();
  //printPolygons();
  //checkIfPointInsidePolygon();
  warnockAlgorithm(0,height,width,0);
  println("end of program");
 
}


void checkIfPointInsidePolygon(){
   point P6 = new point(3, 2);
   point P7 = new point(3, 4); // inside this (concave) polygon
   
   List<point> P = new ArrayList<point>();
    P.add(new point(1, 1));
    P.add(new point(3, 3));
    P.add(new point(9, 1));
    P.add(new point(12, 4));
    P.add(new point(9, 7));
    P.add(new point(1, 7));
    P.add(P.get(0));
   println("Point P6 is inside this polygon = %b\n", inPolygon(P7, polygons.get(0) ) );
  
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
  //fill(#FF0000); //red color
  triangle(200,50,300,120,100,100);
  fill(#FF0000); //red color
  triangle(200+ADD,50+ADD,300+ADD,120+ADD,100+ADD,100+ADD);
  
  fill(#FF0000); //red color
  triangle(220,380,300,120,100,100);
  popStyle();
}
  

void addPolygons(){
   List<point> P = new ArrayList<point>();
   
   P.add( new point(200,50) );
   P.add( new point(300,120) );
   P.add( new point(100,100) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
   
   
   P = new ArrayList<point>();
   
   P.add( new point(200+ADD,50+ADD) );
   P.add( new point(300+ADD,120+ADD) );
   P.add( new point(100+ADD,100+ADD) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
   
   
   P = new ArrayList<point>();
   
   P.add( new point(220,380) );
   P.add( new point(300,120) );
   P.add( new point(100,100) );
   P.add(P.get(0)); // loop back
   polygons.add( P);
}


void warnockAlgorithm(int x1,int y1,int y2, int x2){
  
  HashSet< List<point> > oncePolygons = new HashSet<List<point> >( );
  
 
  int counter=0;
 
  
  boolean isInManyPolygons=false;
  
  int iniPixel= x2 + x1*width;
  if( iniPixel>=360000) iniPixel=359999; 
 
  println( "before "+oncePolygons.size());
  
  //oncePolygons.add( new ArrayList<point>() );
  //println(" size of List of polygons "+polygons.size() );
  
  for ( int y = y1-1; y >=x1; y--) { //height
    for ( int x = y2-1; x >= x2; x--) { //width
          
  
      for( List<point> A: polygons) {
        
       
        if( inPolygon( new point(x,y), A) ){
           //println("there is a point inside a polygon");
           //if( !checkIfListinside( oncePolygons, A ) ) oncePolygons.add( A );
            oncePolygons.add( A );
            
            
        }
      
        
      }
    }
 
  }
  
  counter= oncePolygons.size();
  println( "after "+oncePolygons.size());
  //return;
  
  if( counter>1){ //before: 2
    
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
  
  return cross(toVec(p, q), toVec(p, r)) >= 0; 
}                         // this polygon is convex
      
      
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