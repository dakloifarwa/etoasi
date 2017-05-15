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
 
em_bf = 18.0;
zw_bf = 12.5;
bf_tol = 0.5;
em_ring_h = 3.0;
em_ring_dia = 57.0;
em_ring_width = 5.0 + 2.0;
em_h = em_bf - zw_bf - bf_tol - em_ring_h;
echo(em_h);
 
zw_h = 5.0;
zw_sh = 5.0; // left/right side screw hole diameter
em_sh = zw_sh / 2;
 
protrusion_h = 6.0;
protrusion_dia = em_ring_dia - 2 * (em_ring_width + 2.0);
 
emh_dia = em_ring_dia + 2 * 2.0;
emh_h = em_ring_h - 1.0;
 
asi_dia = 62.0;
asi_h = 28.0;
asi_t_h = 7.4;
asi_t_dia = 50.7;
 
epch_dia = t_dia - 2 * 1.0;
epch_h = asi_t_h - 0.5;
ovl_h = epch_h;
fs_dia = 4.0; // knurled fixation screws
 
module e2t()
{
	difference()
		{
			union()
				{
					cylinder(d=emh_dia, h=em_h, center=true);
					translate([0,0,(em_h+protrusion_h)/2]) cylinder(d=protrusion_dia, h=protrusion_h, center=true); // protrusion
					translate([0,0,-em_h/2-epch_h/2]) cylinder(d=epch_dia, h=epch_h, center=true); // epch
					translate([0,0,em_h/2+(emh_h)/2])
					difference()
						{
							cylinder(d=emh_dia, h=emh_h, center=true);
							translate([0,0,0]) cylinder(d=em_ring_dia+0.6, h=emh_h+0.1, center=true);
						}
				}
			translate([0,0,(protrusion_h - epch_h)/2]) cylinder(d=epc_dia + 0.3, h=em_h+protrusion_h+epch_h+0.1, center=true); // aperture, wider to avoid vignetting
			for (i=[0:2]) // epc fixation screws
				{
					rotate([0,0,i*120+60])  
					translate([0,(epch_dia/2+(epc_dia + 0.3)/2)/2,-em_h/2-epch_h+fs_dia/2+1.0])
					rotate([90,0,0])
					cylinder(d=fs_dia*0.8, h=epch_dia/2-(epc_dia + 0.3)/2+1, center=true);
				}
			//translate([0,0,-(em_h-2.0+0.1)/2]) cylinder(d=t_dia+0.2, h=2.0+0.1, center=true); // T receptable
			//translate([0, (t_dia+c_dia)/2/2,protrusion_h/2]) cylinder(d=em_sh, h=em_h+protrusion_h+0.1, center=true); // screw holes
			//translate([0,-(t_dia+c_dia)/2/2,protrusion_h/2]) cylinder(d=em_sh, h=em_h+protrusion_h+0.1, center=true); //     -"-
		}
	translate([0,0,-(em_h+(ovl_h))/2])
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
			for (i=[0:2]) // epc fixation screw outlet
				{
					rotate([0,0,i*120+60])  
					translate([0,((asi_t_dia + 2 * 0.75)/2+(emh_dia)/2)/2, ovl_h/2-epch_h+fs_dia/2+1.0])
					rotate([90,0,0])
					cylinder(d=fs_dia+0.6, h=(emh_dia)/2-(asi_t_dia + 2 * 0.75)/2+1, center=true);
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
		{
			translate([0,0,em_h/2]) e2t();
			//color("black") translate([0,0,-zw_h/2+1]) t2c();
			*color("darkred") translate([0,0,-asi_h/2 - asi_t_h - 0.2]) asi();
		}
	//translate([0,0,-50]) cube([100,100,100]);
}
