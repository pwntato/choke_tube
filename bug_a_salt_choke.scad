$fn = 100;

constriction_d = 0.75;
choke_h = 20.0;

wall_thickness = 1.0;

loose_padding = 0.5;

barrel_tip_h = 25.0;
bore_d = 5.2;
barrel_d = 13.85;

cross_section = false;

total_h = barrel_tip_h + choke_h;

narrow_h = choke_h / 2.0;
taper_h = choke_h / 2.0;

outer_r = (barrel_d / 2.0) + wall_thickness + loose_padding;
slip_over_r = (barrel_d / 2.0) + loose_padding;
narrow_r = (bore_d - constriction_d) / 2.0;

// cross section
difference() {
	// choke
	difference() {
		// main body
		difference() {
			// body blank
			cylinder(total_h, outer_r, outer_r);

			// slip over cutter
			translate([0, 0, choke_h])
				cylinder(barrel_tip_h + 0.5, slip_over_r, slip_over_r);
		}

		// bore cutter
		union() {
			// narrow cutter
			translate([0, 0, -0.01])
				cylinder(narrow_h + 0.02, narrow_r, narrow_r);
			
			// taper cutter
			translate([0, 0, narrow_h])
				cylinder(taper_h + 0.01, narrow_r, bore_d / 2.0);
		}
	}

	if (cross_section) {
 		translate([-outer_r, 0, -0.5])
 			cube([2 * outer_r, outer_r, total_h + 1.0]);
	}
};


