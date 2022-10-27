$fn=200;
offset_motor = 1;
printer_offset = 1;


motor_breite = 42;
motor_anschluss_breite = 16.5;
motor_anschluss_hoehe = 12;
motor_anschluss_tiefe = 6.5;
motor_tiefe = 10;


bodenplatte_breite = 50;
bodenplatte_tiefe = 10;

bodenplatte_loecher_dm = 5; //M5 Schrauben
bodenplatte_loecher_rahmen = 12;
bodenplatte_loecher_hoehe = 2;

bodenplatte_rahmen_breite = 8;
bodenplatte_rahmen_laenge = 10;
bodenplatte_rahmen_hoehe = 2;

bodenplatte_rahmen_uebergang = 17;

//------------------------------------------
module motor_cutoff() {
    translate([0,0,motor_tiefe/2-1]) cube([motor_breite+offset_motor, 
                            motor_breite+offset_motor, 
                            motor_tiefe+offset_motor], center=true);
    translate([0,0,-3]) cylinder(h=6, d=25, center=true);
}

module bodenplatte_bodenhalter() {
    difference() {
        hull() {
            cylinder(h=bodenplatte_loecher_hoehe, d=bodenplatte_loecher_rahmen, center=true);
            hull() {
                translate([8,0,0]) cube([bodenplatte_rahmen_laenge, 
                        bodenplatte_rahmen_breite, 
                        bodenplatte_rahmen_hoehe], center=true);
               translate([20,0,0]) cylinder(h=bodenplatte_loecher_hoehe, d=bodenplatte_rahmen_uebergang, center=true);
            }            
        }
        cylinder(h=bodenplatte_loecher_hoehe+2, d=bodenplatte_loecher_dm, center=true);
    }
    
}

module connector() {
    //screw mount
    translate([0,23.25,11.5]) cube([10,3.5,13], center=true);
    translate([0,-23.25,11.5]) cube([10,3.5,13], center=true);

    difference() {
        translate([0,30,2.5+13]) cube([10,10,5], center=true);
        translate([0,30,2.5+13]) cylinder(h=12, d=4, center=true);
    }
    difference() {
        translate([0,-30,2.5+13]) cube([10,10,5], center=true);
        translate([0,-30,2.5+13]) cylinder(h=12, d=4, center=true);
    }
}

module bodenplatte(){
    difference() {
       cube([bodenplatte_breite, bodenplatte_breite, bodenplatte_tiefe],center=true);
        motor_cutoff();
    }
    connector();
}

bodenplatte();
//motor_cutoff();
