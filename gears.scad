use <parametric_involute_gear_v5.0.scad>;
use <snippets.scad>;

small_teeth = 10;
large_teeth = 33;
spacing = 39.5;
diametral_pitch = (small_teeth + large_teeth) / (2 * spacing);

small();
translate([spacing, 0, 0]) large();

$fa = $fa / 4;
$fs = $fs / 4;

module small() {
    translate([0, 0, 13]) rotate(180, [1, 0, 0]) rotate(($t*small_teeth*large_teeth + 1/14) * 360 / small_teeth, [0, 0, 1]) {
        render() difference() {
            render() gear(number_of_teeth=small_teeth,
                          diametral_pitch=diametral_pitch,
                          bore_diameter=5,
                          pressure_angle=32,
                          twist = 360 / small_teeth * 14 / 12,
                          gear_thickness=14,
                          hub_thickness=21,
                          hub_diameter = 22,
                          addendum=.9,
                          clearance=.4,
                          rim_thickness=14);
            translate([0, 0, 17.5]) rotate(90, [0, 1, 0]) {
                hull() {
                    // We make the hole for the M3 nut bigger than it needs to
                    // be (flat width 5.5, hole width 7 but we shallow the hole
                    // a bit so the nut will still line up with the bolt hole
                    // when at the bottom
                    translate([-.5/cos(30), 0, 4]) hexa_prz(3.5, 3);
                    translate([-6, 0, 4]) hexa_prz(3.5, 3);
                }
                render() intersection() {
                    cube([100, 3, 100], center=true);
                    hull() {
                        translate([0, 0, 2]) hexa_prz(3, 3);
                        translate([-5, 0, 2]) hexa_prz(3, 3);
                    }
                }
                translate([0, 0, 7.5]) rotate(30, [0, 0, 1]) hexa_prz(1.6, 13);
            }
        }
    }
}

module large() {
    rotate($t*small_teeth*large_teeth * 360 / large_teeth, [0, 0, 1]) {
        render() difference() {
            render() gear(number_of_teeth=large_teeth,
                          diametral_pitch=diametral_pitch,
                          bore_diameter=8,
                          pressure_angle=32,
                          twist = -360 / large_teeth,
                          hub_diameter=18,
                          hub_thickness=12,
                          gear_thickness=5,
                          addendum=.9,
                          clearance=.4,
                          rim_thickness=12);
            // Hex hole
            translate([0, 0, 6]) linear_extrude(6) { hexa(apothem=6.5); }
            // Tapers in at the bottom for a snugger fit
            translate([0, 0, 5]) linear_extrude(1, scale = 6.5 / 6) { hexa(apothem=6); }
        }
    }
}

