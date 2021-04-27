/* create Mandelbrot dataset */
data indata;
	n = 600;  m = 600;
	pmin = -2.5; pmax = 1.5;
	qmin = -1.5; qmax =  1.5;
	r = 100.0;
	maxiterate = 50;
    do k = 1 to n*m;
        i = int(k/m);
        j = int(mod(k,m));
        p = i*(pmax-pmin)/(n-1)+pmin;
        q = j*(qmax-qmin)/(m-1)+qmin;
        output;
	end;
	keep p q r maxiterate;
run;
quit;


/* Compute the coordinates */
data mandelbrot;
	set indata;
    keep p q mesh;
    x = p;
    y = q;
    rr = r**2;
    mesh = 0;
    do while (mesh < maxiterate and (x**2+y**2 < rr));
        nx = x**2 - y**2 + p;
        ny = 2.0*x*y + q;
        x = nx;
        y = ny;
        mesh = mesh+1;
    end;
run;


/* set color options */
goptions colors= (
CX003366 CX336699 CX6699CC CX99CCFF CX006633 CX339966 CX66CC99 CX99FFCC
CX336600 CX669933 CX99CC66 CXCCFF99 CX663300 CX996633 CXCC9966 CXFFCC99
CX660033 CX993366 CXCC6699 CXFF99CC CX003366 CX663399 CX9966CC CXCC99FF
CX003366 CX663399 CX9966CC CXCC99FF CX003366 CX663399 CX9966CC CXCC99FF
CX003366 CX663399 CX9966CC CXCC99FF CX003366 CX663399 CX9966CC CXCC99FF
black black black black black black black black
)
;

/* Drawing Mandelbrot Sets */
proc gcontour data=mandelbrot;
   Title 'Mandelbrot Set';
   plot q*p=mesh /
   nolegend
   pattern
   join
   levels = 3 to 50
  ;
run;
