//----------------------------------------------------------------------------------------------------------------------
// Customization Parameters:
// Specify which part to print to a STL file:
print_part = "all"; // "all", "backholder", "asiholder"
//----------------------------------------------------------------------------------------------------------------------
 
min_wt = 3.0;
$fn=300;
 
t_dia = 42.0;
epc_dia = 25.4 * 1.25;
c_dia = 25.4;
filter_dia = 36.0;
filter_t = 2.0;
 
emh_dia = 59.0 + 2 * 3.0;
emh_h = 5.0 + 0.4;

em_bf = 18.0;
zw_bf = 12.5;
bf_tol = 0.5;
 
em_inner_dia = 41.4; // of the lens
emb_upper_dia = 47.2;
emb_lower_dia = 46.0;
 
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
lsh = emh_h;
fs_dia = 4.0; // knurled fixation screws M4

// holder dimensions:
sn_sw = 7.0; // M4 screw nut dimensions
sn_h = 3.2 + 0.3; // includes tolerance!
holder_screw = 4.0; // M4 screw for holder
sn_hole = holder_screw + 0.5;
holder_ear_dia = 2*(sn_sw*2)/sqrt(3);
sn_slot_l = holder_ear_dia/2 + 10.0;

module asiholder()
{
	h1=1.4;
	h2=2.3;
	t1=1.3;
	dist1=1.6;
	a1=43; // angles
	a2=64;
	a3=57;
	a4=62;
	a5=80;
	//a6=54;
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
			cylinder(d=asi_t_dia + 2 * 0.3, h=(ovl_h)+0.1, center=true);
			for (i=[0:2]) // camera fixation screws
				{
					rotate([0,0,i*120])
					translate([0,((asi_t_dia + 2 * 0.3)/2+(emh_dia)/2)/2,0])
					rotate([90,0,0])
					cylinder(d=fs_dia*0.8, h=(emh_dia)/2-(asi_t_dia + 2 * 0.3)/2+1, center=true);
				}
		}
	translate([0,0,-(ovl_h)-3/2])
	difference() 
		{
			 union()
				{
					cylinder(d=emh_dia, h=lsh, center=true);
					for (i=[0:2]) // holder ears
						{
							rotate([0,0,i*120]) translate([emh_dia/2,0,0]) cylinder(d=holder_ear_dia, h=lsh, center=true);
						}
				}
			 
			 cylinder(d=asi_dia+2*0.3, h=lsh+0.1, center=true);
			 for (i=[0:2]) // holder screw holes
				{
					rotate([0,0,i*120]) translate([emh_dia/2 + sn_hole/2 + 1.0,0,0])
					union()
						{
							cylinder(d=sn_hole, h=lsh+0.1, center=true);
							cylinder(d=(sn_sw*2)/sqrt(3), h=sn_h, center=true, $fn=6); // screw nut
							translate([sn_slot_l/2,0,0]) rotate([0,90,90]) cube([sn_h,sn_slot_l,sn_sw], center=true); // slot
						}
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

//----- backholder -----
bh_h = 4.0;
bh_outer_dia = emh_dia+1;
bh_inner_dia = asi_dia - 2 * 2.0;
bh_asi_ovl = 2.0;
 
module backholder()
{
	difference()
		{
			union()
				{
					cylinder(d=bh_outer_dia, h=bh_h, center=true);
					for (i=[0:2]) // holder ears
						{
							rotate([0,0,i*120]) translate([emh_dia/2,0,0]) cylinder(d=holder_ear_dia, h=bh_h, center=true);
						}
				}
			
			translate([0,0,0]) cylinder(d=bh_inner_dia, h=bh_h+0.1, center=true);
			translate([0,0,bh_asi_ovl]) cylinder(d=asi_dia+2*0.3, h=bh_h+0.1, center=true);
			for (i=[0:2]) // holder screw holes
				{
					rotate([0,0,i*120]) translate([emh_dia/2 + sn_hole/2 + 1.0,0,0])
					cylinder(d=sn_hole, h=bh_h+0.1, center=true);
				}
		}
}
//----- end backholder -----

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
		{
			color("darkblue") asiholder();
			//*color("grey") translate([0,0,-zw_h/2]) t2c();
			//*color("darkred") translate([0,0,-asi_h/2 - asi_t_h - 0.2]) asi();
			translate([0,0,-asi_h - asi_t_h - 0.2    +bh_asi_ovl]) backholder();
		}
	// hide the irrelevant part:
		if (print_part != "all")
		{
			if (print_part == "backholder")
			{
				translate([0,0,100/2-20]) cube([100,100,100], center=true);
			}
			if (print_part == "asiholder")
			{
				translate([0,0,-100/2-20]) cube([100,100,100], center=true);
			}
			
		}	

	
	*translate([0,0,-50]) cube([100,100,100]);
}
 
