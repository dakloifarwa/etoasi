//----------------------------------------------------------------------------------------------------------------------
// Customization Parameters:
 
//----------------------------------------------------------------------------------------------------------------------
 
min_wt = 3.0;
$fn=300;
 
t_dia = 42.0;
epc_dia = 25.4 * 1.25;
c_dia = 25.4;
filter_dia = 36.0;
filter_t = 2.0;
 
emh_dia = 59.0 + 2 * 2.0;
emh_h = 5.0 + 0.4;

em_bf = 18.0;
zw_bf = 12.5;
bf_tol = 0.5;
 
em_inner_dia = 41.4; // of the lens
emb_upper_dia = 47.2;
emb_lower_dia = 46.3;
 
asi_dia = 62.0;
asi_h = 28.0;
asi_t_h = 7.4;
asi_t_dia = 50.7;
 
zw_h = asi_t_h;
zw_sh = 5.0; // left/right side screw hole diameter
em_sh = zw_sh / 2;
 
epch_dia = t_dia - 2 * 1.0;
epch_h = asi_t_h - 0.5;
ovl_h = epch_h;
fs_dia = 4.0; // knurled fixation screws M4
 
module e2t()
{
	h1=1.4;
	h2=2.0;
	t1=1.3;
	dist1=1.3;
	a1=43; // angles
	a2=54;
	a3=80;
	a4=62;
	a5=57;
	//a6=65;
	a7=6; // orientation marker
	b1=2.5;
	
	ah1 = atan((h2 - h1)/(a1 / 360 * (emb_upper_dia - t1) * 3.142)); // wedge angle
	ah2 = b1 * 360 / ((emb_upper_dia - t1) * 3.142);
	
	d1=3.0;
 
	union()
		{
			translate([0,0,(emh_h)/2])
			difference()
				{
					cylinder(d=emh_dia, h=emh_h, center=true);
					translate([0,0,0]) cylinder(d1=emb_lower_dia, d2=emb_upper_dia, h=emh_h+0.1, center=true);
				}
		}
 
	rotate([0,0,0])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a1, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
	rotate([0,0,a1+a2])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a3, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			rotate([0,0,0]) translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
	rotate([0,0,a1+a2+a3+a4])
	union()
		{
			translate([0, 0, emh_h-h2/2-dist1])
			difference()
				{
					rotate_extrude(angle=a5, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,h2], center=true);
					rotate([ah1,0,0]) translate([0, 0, -h2/2-5.0/2]) cylinder(d=emb_upper_dia, h=5.0, center=true);
				}
			rotate([0,0,0]) translate([0, 0, (emh_h-h2-dist1+0.5)/2]) rotate_extrude(angle=ah2, convexity = 10) translate([emb_upper_dia/2-t1/2+1.0/2, 0, 0]) square([t1+1.0,emh_h-h2-dist1+0.5], center=true);
		}
 
rotate([0,0,a1-a7]) translate([emh_dia/2,0,emh_h-d1/2-1]) rotate([0,90,0]) cylinder(d=d1, h=2, center=true); // orientation marker
 
*translate([0, 0, emh_h-h2/2-dist1])
difference()
	{
		cylinder(d=emb_upper_dia, h=h2, center=true);
	}
	
	translate([0,0,-((ovl_h))/2])
	difference() // overlap
		{
			cylinder(d=emh_dia, h=(ovl_h), center=true);
			cylinder(d=asi_t_dia + 2 * 0.75, h=(ovl_h)+0.1, center=true);
			for (i=[0:2]) // camera fixation screws
				{
					rotate([0,0,i*120])
					translate([0,((asi_t_dia + 2 * 0.75)/2+(emh_dia)/2)/2,0])
					rotate([90,0,0])
					cylinder(d=fs_dia*0.8, h=(emh_dia)/2-(asi_t_dia + 2 * 0.75)/2+1, center=true);
				}
		}
}
 
module t2c()
{
	difference()
		{
			cylinder(d=t_dia, h=zw_h, center=true); // T
			cylinder(d=c_dia, h=zw_h+0.1, center=true); // C
			translate([0, (t_dia+c_dia)/2/2,0]) cylinder(d=zw_sh, h=zw_h+0.1, center=true); // screw holes
			translate([0,-(t_dia+c_dia)/2/2,0]) cylinder(d=zw_sh, h=zw_h+0.1, center=true); //     -"-
		}
}
 
module asi()
{
	cylinder(d=asi_dia, h=asi_h, center=true);
	translate([0,0,(asi_h + asi_t_h)/2])
	difference()
		{
			cylinder(d=asi_t_dia, h=asi_t_h, center=true);
			translate([0,0,0.1/2]) cylinder(d=t_dia, h=asi_t_h+0.1, center=true);
		}
}
 
difference()
{
	union()
			translate([0,0,0]) e2t();
		{
			//*color("grey") translate([0,0,-zw_h/2]) t2c();
			*color("darkred") translate([0,0,-asi_h/2 - asi_t_h - 0.2]) asi();
		}
	*translate([0,0,-50]) cube([100,100,100]);
}
 
