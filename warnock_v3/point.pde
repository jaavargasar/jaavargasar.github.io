    
    
    class point implements Comparable<point>{
      double x, y;                   // only used if more precision is needed
      point() { x = y = 0.0; }                         // default constructor
      point(double _x, double _y) { x = _x; y = _y; }         // user-defined
      // use EPS (1e-9) when testing equality of two floating points
      public int compareTo(point other) {      // override less than operator
        if (Math.abs(x - other.x) > EPS)                // useful for sorting
          return (int)Math.ceil(x - other.x);       // first: by x-coordinate
        else if (Math.abs(y - other.y) > EPS)
          return (int)Math.ceil(y - other.y);      // second: by y-coordinate
        else
          return 0; } 
        
      double getX(){return this.x;}
      
      double getY(){return this.y;}
    
  };                                    // they are equal