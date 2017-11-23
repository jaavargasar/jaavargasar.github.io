class point implements Comparable<point>{
   
  double x, y,z;                   // only used if more precision is needed
  
  point() { 
    x = y = z =0.0; 
  }                         // default constructor
  
  point(double _x, double _y, double _z) { 
      x = _x; 
      y = _y; 
      this.z= _z;
  }         // user-defined
   
   // use EPS (1e-9) when testing equality of two floating points
  public int compareTo(point other) {      // override less than operator
      
      if (Math.abs(x - other.x) > EPS)                // useful for sorting
         return (int)Math.ceil(x - other.x);       // first: by x-coordinate
        
      else if (Math.abs(y - other.y) > EPS)
         return (int)Math.ceil(y - other.y);      // second: by y-coordinate
     
     else if( Math.abs( z- other.z) >EPS)
         return (int)Math.ceil(z-other.z);
     
      else
         return 0; 
   } 
        
   double getX(){
     return this.x;
   }
      
   double getY(){
     return this.y;
   }
   
   double getZ(){
      return this.z; 
 
   }
    
};                                    // they are equal