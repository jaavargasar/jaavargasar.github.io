class point implements Comparable<point>{
   
  double x, y,z;                   
  
  point() { 
    x = y = z =0.0; 
  }                      
  
  point(double _x, double _y, double _z) { 
      x = _x; 
      y = _y; 
      this.z= _z;
  }         
   
 
  public int compareTo(point other) {      
      
      if (Math.abs(x - other.x) > EPS)               
         return (int)Math.ceil(x - other.x);       
        
      else if (Math.abs(y - other.y) > EPS)
         return (int)Math.ceil(y - other.y);      
     
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
    
};                                    