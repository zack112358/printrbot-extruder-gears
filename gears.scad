use <parametric_involute_gear_v5.0.scad>;

small_teeth = 10;
large_teeth = 33;
spacing = 39.5;
diametral_pitch = (small_teeth + large_teeth) / (2 * spacing);

small();
translate([spacing, 0, 0]) large();

$fa = $fa / 4;
$fs = $fs / 4;

module small() {
    translate([0, 0, 12]) rotate(180, [1, 0, 0])
    rotate($t * 360 / small_teeth, [0, 0, 1])
    render() gear(number_of_teeth=small_teeth,
                  diametral_pitch=diametral_pitch,
                  bore_diameter=5,
                  pressure_angle=30,
                  twist = 360 / small_teeth,
                  gear_thickness=13,
                  hub_thickness=20,
                  clearance=.5,
                  hub_diameter = 22,
                  rim_thickness=13);
}

module large() {
    rotate($t * 360 / large_teeth, [0, 0, 1])
    render() gear(number_of_teeth=large_teeth,
                  diametral_pitch=diametral_pitch,
                  bore_diameter=8,
                  pressure_angle=30,
                  twist = -360 / large_teeth,
                  hub_diameter=18,
                  hub_thickness=12,
                  clearance=1,
                  gear_thickness=5,
                  rim_thickness=12);
}

