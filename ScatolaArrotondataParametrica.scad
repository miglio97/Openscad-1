altezza = 35;
larghezza = 65;
profondita = 85;
arrotondamento = 12;
$fn=100;
module scatola(){
    
    translate([0,0,altezza/2]){
        difference(){
            roundedBox([larghezza,profondita,altezza], arrotondamento, true);
            translate([0,0,2]){
                roundedBox([larghezza-3,profondita-3,altezza+2], arrotondamento, true);
            }    
        }    
    }   
}
module coperchio(){
    translate([0,0,altezza]){
        roundedBox([larghezza-3,profondita-3,2], arrotondamento, true);
        translate([0,0,2]){
            roundedBox([larghezza,profondita,2], arrotondamento, true);
        }    
    }    
}
module roundedBox(size, radius, sidesonly)
{
	rot = [ [0,0,0], [90,0,90], [90,90,0] ];
	if (sidesonly) {
		cube(size - [2*radius,0,0], true);
		cube(size - [0,2*radius,0], true);
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				 y = [radius-size[1]/2, -radius+size[1]/2]) {
			translate([x,y,0]) cylinder(r=radius, h=size[2], center=true);
		}
	}
	else {
		cube([size[0], size[1]-radius*2, size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1], size[2]-radius*2], center=true);
		cube([size[0]-radius*2, size[1]-radius*2, size[2]], center=true);

		for (axis = [0:2]) {
			for (x = [radius-size[axis]/2, -radius+size[axis]/2],
					y = [radius-size[(axis+1)%3]/2, -radius+size[(axis+1)%3]/2]) {
				rotate(rot[axis]) 
					translate([x,y,0]) 
					cylinder(h=size[(axis+2)%3]-2*radius, r=radius, center=true);
			}
		}
		for (x = [radius-size[0]/2, -radius+size[0]/2],
				y = [radius-size[1]/2, -radius+size[1]/2],
				z = [radius-size[2]/2, -radius+size[2]/2]) {
			translate([x,y,z]) sphere(radius);
		}
	}
}



scatola();
coperchio();
