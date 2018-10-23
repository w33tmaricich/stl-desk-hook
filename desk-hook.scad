//Lip measurements
LIP_HEIGHT = 8.35;
LIP_WIDTH = 9.69;

// Hook Measurements
HOOK_HEIGHT = 4*LIP_HEIGHT;
HOOK_WIDTH = 15;

// Thickness of the piece
PADDING = 2;

// Universal Measurements
DEPTH=2;

// create the lip
//square([LIP_WIDTH+PADDING, LIP_HEIGHT+PADDING], false);

// Create the hook.
module hook() {
    difference() {
        square([HOOK_WIDTH, HOOK_HEIGHT], false);
            translate([PADDING,PADDING,0]) {
                square([HOOK_WIDTH-2*PADDING, HOOK_HEIGHT], false);
            }
        translate([PADDING*2,HOOK_WIDTH,0]) {
            square([HOOK_HEIGHT, HOOK_HEIGHT],false);
        }
    }
}

module lip() {
    union() {
        difference() {
            square([LIP_WIDTH+2*PADDING, LIP_HEIGHT+2*PADDING], true);
            square([LIP_WIDTH, LIP_HEIGHT], true);
            translate([-PADDING*2,PADDING*2,0]) {
                square([LIP_WIDTH, LIP_HEIGHT], true);
            }
        }
        
        translate([0,PADDING+PADDING/2,0]) {
            square([PADDING,LIP_HEIGHT/4+2*PADDING], true);
        }
    }
}




module component(depth=DEPTH) {
    linear_extrude(height = depth, center = true) {
        translate([-LIP_WIDTH/2,0,0]) {
            lip();
        }
        translate([0,-HOOK_HEIGHT,0]) {
            hook();
        }
    }
}

component();