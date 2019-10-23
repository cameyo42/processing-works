// moon phase
// by cameyo 2017

// Input dialog
import javax.swing.JOptionPane;

PFont font;
int yy, mm, dd; // current date
String[] monthNames = {"january","february","march","april","may","june","july","august","september","october","november","december"};
int[] monthDays = {31,28,31,30,31,30,31,31,30,31,30,31};
int moonDay; // moon age in days: 0..29
int numImages = 30;
PImage[] moonIMGs = new PImage[numImages];
PImage moonPhasesIMG;
PImage phaseIMG;

void setup()
{
  size(300,300);
  smooth();
  font = createFont("Courier New Bold", 16);
  moonPhasesIMG = loadImage("moonPhases.jpg");
  textFont(font);
  textAlign(CENTER);
  imageMode(CENTER);
  yy = year();
  mm = month();
  dd = day();
}

void draw()
{
  background(0);
  int moonDay = (int)MoonAge_trig01(yy, mm, dd);
  //int moonDay = MoonAge_conway(yy, mm, dd);
  //int moonDay = MoonAge_trig01(yy, mm, dd);
  //int moonDay = MoonAge_trig02(yy, mm, dd);
  phaseIMG = moonPhasesIMG.get(moonDay*280, 0, 280, 280);
  image(phaseIMG, width/2, height/2);  
  text(yy + "-" + monthNames[mm-1] + "-" + dd, width/2, 20);
  text("moon day: " + moonDay, width/2, 290);
}

// Calculate the approximate moon's age in days (Conway)
// This is based on a 'do it in your head' algorithm by John Conway. 
// It's only valid for the 20th and 21st centuries.
double MoonAge_conway(int theYear, int theMonth, int theDay) 
{	
	double r = theYear % 100;
	r %= 19;
	if (r>9){ r -= 19;}
	r = ((r * 11) % 30) + theMonth + theDay;
	if (theMonth<3){r += 2;}
	r -= ((theYear<2000) ? 4 : 8.3);
	r = Math.floor(r+0.5)%30;
	return (r < 0) ? r+30 : r;
}  

// Calculate the approximate moon's age in days (trig01)
// This is based on some Basic code by Roger W. Sinnot from Sky & Telescope magazine, March 1985. 
// I don't understand it very well :-)
double MoonAge_trig01(int theYear, int theMonth, int theDay) 
{
	double thisJD = jultheDay(theYear,theMonth,theDay);
	double degToRad = 3.14159265 / 180;
	double K0, T, T2, T3, J0, F0, M0, M1, B1, oldJ;
	K0 = Math.floor((theYear-1900)*12.3685);
	T = (theYear-1899.5) / 100;
	T2 = T*T; T3 = T*T*T;
	J0 = 2415020 + 29*K0;
	F0 = 0.0001178*T2 - 0.000000155*T3 + (0.75933 + 0.53058868*K0) - (0.000837*T + 0.000335*T2);
	M0 = 360*(GetFrac(K0*0.08084821133)) + 359.2242 - 0.0000333*T2 - 0.00000347*T3;
	M1 = 360*(GetFrac(K0*0.07171366128)) + 306.0253 + 0.0107306*T2 + 0.00001236*T3;
	B1 = 360*(GetFrac(K0*0.08519585128)) + 21.2964 - (0.0016528*T2) - (0.00000239*T3);
	double phase = 0.0;
	double jtheDay = 0.0;
  oldJ = 0.0;
	while (jtheDay < thisJD) {
		double F = F0 + 1.530588*phase;
		double M5 = (M0 + phase*29.10535608)*degToRad;
		double M6 = (M1 + phase*385.81691806)*degToRad;
		double B6 = (B1 + phase*390.67050646)*degToRad;
		F -= 0.4068*Math.sin(M6) + (0.1734 - 0.000393*T)*Math.sin(M5);
		F += 0.0161*Math.sin(2*M6) + 0.0104*Math.sin(2*B6);
		F -= 0.0074*Math.sin(M5 - M6) - 0.0051*Math.sin(M5 + M6);
		F += 0.0021*Math.sin(2*M5) + 0.0010*Math.sin(2*B6-M6);
		F += 0.5 / 1440; 
		oldJ=jtheDay;
		jtheDay = J0 + 28*phase + Math.floor(F); 
		phase++;
	}
	return (thisJD-oldJ)%30;
}

// Calculate the approximate moon's age in days (trig02)
// This is the same algorithm of trig01, but written in other way. 
double MoonAge_trig02(int theYear, int theMonth, int theDay) 
{
  double n, RAD, t, t2, as, am, xtra, i, j1, jd;
	n = Math.floor(12.37 * (theYear -1900 + ((1.0 * theMonth - 0.5)/12.0)));
	RAD = 3.14159265/180.0;
	t = n / 1236.85;
	t2 = t * t;
	as = 359.2242 + 29.105356 * n;
	am = 306.0253 + 385.816918 * n + 0.010730 * t2;
	xtra = 0.75933 + 1.53058868 * n + ((1.178e-4) - (1.55e-7) * t) * t2;
	xtra += (0.1734 - 0.000393 * t) * Math.sin(RAD * as) - 0.4068 * Math.sin(RAD * am);
	i = (xtra > 0.0 ? Math.floor(xtra) :  Math.ceil(xtra - 1.0));
	j1 = jultheDay(theYear,theMonth,theDay);
	jd = (2415020 + 28 * n) + i;
	return (j1-jd + 30)%30;
}

// getfrac function
double GetFrac(double fr) {	return (fr - Math.floor(fr)); }

//Julian Day Number (for trig functions).
double jultheDay(int theYear, int theMonth, int theDay) 
{
  int jy, jm;
  double ja, jul;
	if (theYear < 0) { theYear ++; }
	jy = theYear;
	jm = theMonth + 1;
	if (theMonth <= 2) {jy--;	jm += 12;	} 
	jul = Math.floor(365.25 *jy) + Math.floor(30.6001 * jm) + theDay + 1720995;
	if (theDay+31*(theMonth+12*theYear) >= (15+31*(10+12*1582))) 
  {
		ja = Math.floor(0.01 * jy);
		jul = jul + 2 - ja + Math.floor(0.25 * ja);
	}
	return jul;
}

// Julian Day Number (alternative method).
int JulianDate(int d, int m, int y)
{ 
    int mm, yy;
    int k1, k2, k3;
    int j;

    yy = y - (int)((12 - m) / 10);
    mm = m + 9;
    if (mm >= 12)
    {
        mm = mm - 12;
    }
    k1 = (int)(365.25 * (yy + 4712));
    k2 = (int)(30.6001 * mm + 0.5);
    k3 = (int)((int)((yy / 100) + 49) * 0.75) - 38;
    // 'j' for dates in Julian calendar:
    j = k1 + k2 + d + 59;
    if (j > 2299160)
    {
        // For Gregorian calendar:
        j = j - k3; // 'j' is the Julian date at 12h UT (Universal Time)
    }
    return j;
}

void mousePressed()
{
  inputDate();
}

void inputDate()
{
  String valDate = JOptionPane.showInputDialog("Enter Date: (d-m-y or d m y or d,m,y)...");
  if (valDate != null) // Press cancel and valid string
  {
    String[] val = splitTokens(valDate, "-, ");
    if (val.length == 3)
    {
      try
      {
        int d = Integer.parseInt(val[0]);
        int m = Integer.parseInt(val[1]);
        int y = Integer.parseInt(val[2]);
        d = constrain(d,1,31);
        m = constrain(m,1,12);
        y = constrain(y,1900,2500);
        // println(d,m,y);
        dd = d;
        mm = m;
        yy = y;
      }
      catch (NumberFormatException e)
      {
        println("Error: wrong Date values");
      }
    }
    else { println("Error: wrong Date values"); }
  }
}

void keyPressed()
{
  if (keyCode==112) // F1
  {

  }
  if (keyCode == LEFT)
  {
     minusDayCheck(dd,mm,yy);
  }
  if (keyCode == RIGHT)
  {
     plusDayCheck(dd,mm,yy);
  }  
}  

void minusDayCheck(int theDay, int theMonth, int theYear)
{
  if (theDay == 1) // mese precedente?
  { 
    if (theMonth == 1) // anno precedente?
    { 
      theDay = 31;
      theMonth = 12;
      theYear = theYear - 1;
    }
    else // anno corrente AND mese precedente
    {
      if (isLeapYear(theYear)) 
      { 
        monthDays[1] = 29;
      }
      else 
      {
        monthDays[1] = 28;
      }
      theDay = monthDays[theMonth-2];
      theMonth = theMonth - 1;
      theYear = theYear;
    }
  }
  else // mese corrente
  {
    theDay = theDay - 1;
    theMonth = theMonth;
    theYear = theYear;
  }
  //println(theDay+"-"+theMonth+"-"+theYear);  
  yy = theYear;
  mm = theMonth;
  dd = theDay;  
}

void plusDayCheck(int theDay, int theMonth, int theYear)
{
  if (isLeapYear(theYear)) { monthDays[1] = 29; }
  else { monthDays[1] = 28;}
  if (theDay == monthDays[theMonth-1]) // mese successivo?
  { 
    if (theMonth == 12) // anno successivo?
    { 
      theDay = 1;
      theMonth = 1;
      theYear = theYear + 1;
    }
    else // anno corrente AND mese successivo
    {
      theDay = 1;
      theMonth = theMonth + 1;
      theYear = theYear;
    }
  }
  else // mese corrente
  {
    theDay = theDay + 1;
    theMonth = theMonth;
    theYear = theYear;
  }
  //println(theDay+"-"+theMonth+"-"+theYear);
  yy = theYear;
  mm = theMonth;
  dd = theDay;
}

boolean isLeapYear (int theYear)
{
  if (((theYear % 4 == 0) && (theYear % 100 != 0)) || (theYear % 400 == 0))
  { return true; }
  else 
  { return false; }
}    