//Adaptation of the orginal hotend fan mount for the mini Kossel
//Tony@think3dprint3d.com
//Gpl v3

include <configuration.scad>;

barrel_radius = 11;
barrel_height = 26.2;

groove_radius = 6.0;
groove_height = 6.0;

fanVoffset=0;
extraHeight=0;
fan_offset = 18;
nozzleHeight=58;

IRflangeThickness=6;
IRboardFixingCentres=21.11-2.70;
IRboardFixingOffset=4+7.5+3.5;
IRboardFixingHeight=nozzleHeight-15.875-1.5;
IRboardWidth=24.6;

m3VertExtraRadius=0.0;

overlap=0.01;

module hotend_fan() {
  difference() {
    union() {
      // Main body
      translate([0, 2 - fan_offset, 0])
        cylinder(r=22, h=40+extraHeight, $fn=8);
      // Groove mount body
      translate([0, 2, groove_height/2])
        cube([32, 26, groove_height], center=true);
      // Flange for IR sensor
      translate([-IRboardWidth/2,-IRboardFixingOffset-overlap,IRboardFixingHeight-3])
        cube([24,IRflangeThickness+overlap,7]);
    }

    // Groove mount insert slot.
    translate([0, 10, 0])
      cube([2*(groove_radius+0.1), 20, 20], center=true);
    // Angle for second fan mount
    translate([0, 28.2, groove_height/2+6]) rotate([60,0,0])
        cube([41, 40, 20], center=true); 
    // Groove mount.
    cylinder(r=groove_radius+0.1, h=200, center=true, $fn=24);

    // E3Dv6 barrel.
    translate([0, 0, groove_height - 0.2]) cylinder(r=8.1, h=100, $fn=24);
    translate([-8.1,0,groove_height-0.2]) cube([2*8.1,100,100]);
    translate([0, 0, groove_height + 6]) cylinder(r=barrel_radius + 0.75, h=100, $fn=24);
    translate([-(barrel_radius+0.75),0,groove_height+6]) cube([2*(barrel_radius+0.5),100,100]);

    // Fan mounting surface and screws.
    translate([0, -50 - fan_offset, 0])
      cube([100, 100, 100], center=true);
    for (x = [-16, 16]) {
      for (z = [-16, 16]) {
        translate([x, -fan_offset, z+20+fanVoffset]) rotate([90, 0, 0]) 
          cylinder(r=m3_radius, h=16, center=true, $fn=12);
      }
    }
    // Air funnel.
    difference() {
      translate([0, -6- fan_offset, 20+fanVoffset+1])
        scale([1,1,0.9])
          rotate([-75, 0, 0])
            cylinder(r1=21, r2=0, h=35, $fn=36);
      translate([-50,-50,34.5]) cube([100,100,100]);
    }
    // Main mounting holes
    for (a = [60:60:359]) {
      rotate([0, 0, a]) translate([0, 12.2, 0]) 
        cylinder(r=m3_radius+m3VertExtraRadius, h=12.2, center=true, $fn=12);
    }
    // IR board mount
	translate([-IRboardWidth/2,-IRboardFixingOffset-10,IRboardFixingHeight-3.0])
		cube([IRboardWidth,10,30]);
	translate([-12/2,-IRboardFixingOffset+1.5-10,IRboardFixingHeight-1]) cube([12,10,50]);
	translate([-12/2,-IRboardFixingOffset+1.5-10/2,IRboardFixingHeight+4])
		rotate([0,45,0]) cube([4,10,4],center=true);
	// fixing holes
   translate([-IRboardFixingCentres/2,-IRboardFixingOffset-overlap,IRboardFixingHeight])
		rotate([-90,0,0]) cylinder(r=1.2, h=6+2*overlap, $fn=12);
   translate([IRboardFixingCentres/2,-IRboardFixingOffset-overlap,IRboardFixingHeight])
		rotate([-90,0,0]) cylinder(r=1.2, h=6+2*overlap, $fn=12);
  }

  //second fan mount
  difference(){
     translate([0, 13, groove_height/2+4]) rotate([60,0,0])
        cube([40, 18, groove_height], center=true); 
	 //cutout for second fan
 	 translate([0, 30, 20]) rotate([60,0,0])
	 cylinder(r=19, h=30, center=true);
    // Groove mount insert slot.
    translate([0, 10, 0])
      cube([2*groove_radius, 20, 20], center=true);
    translate([0, 10, groove_height + 0.02])
      cube([2*(barrel_radius + 1), 20, 20], center=true);
   //smooth bottom
    translate([0, 0,-10])
      cube([50, 50, 20], center=true);
    //dont obstruct mountng holes
    for (a = [-60:120:60]) {
      rotate([0, 0, a]) translate([0, 12.5, 5]) 
        cylinder(r=m3_radius, h=12, center=true, $fn=12);
    }
    translate([0, 13, groove_height/2+4])
    rotate([-30,0,0])
	   for (x = [-16, 16]) {
        translate([x, 0, 4]) rotate([90, 0, 0]) 
          cylinder(r=m3_radius, h=16, center=true, $fn=12);
      }

  }
}

hotend_fan();
// IR board mounting tab
//difference() {
//	translate([4+7.5+4,-25/2,35]) cube([5,25,8]);
//  translate([0.01,-IRboardFixingCentres/2,IRboardFixingHeight])
//		rotate([0,-90,0]) cylinder(r=1.2, h=7, $fn=12);
//   translate([0.01,IRboardFixingCentres/2,IRboardFixingHeight])
//		rotate([0,-90,0]) cylinder(r=1.2, h=7, $fn=12);
//}


/*
// Hotend barrel.
translate([0, 0, groove_height]) %
  cylinder(r=barrel_radius, h=barrel_height);

// 40mm fan.
translate([0, -5 - fan_offset, 20]) % difference() {
  cube([40, 10, 40], center=true);
  rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
}
// second40mm fan.

translate([0, 30, 20])
rotate([-30,0,0]) 
% difference() {
  cube([40, 10, 40], center=true);
  rotate([90, 0, 0,]) cylinder(r=19, h=20, center=true);
}*/
