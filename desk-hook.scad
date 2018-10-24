//Lip measurements
LIP_HEIGHT = 8.35;
LIP_WIDTH = 9.69;
LIP_GAP = 20.32;

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

// Half of the finished support
module lip() {
    union() {
        difference() {
            // Main outer edge
            square([LIP_WIDTH+2*PADDING, LIP_HEIGHT+2*PADDING], true);
            // Center cut out
            square([LIP_WIDTH, LIP_HEIGHT], true);
            translate([-PADDING*2,PADDING*2,0]) {
                square([LIP_WIDTH, LIP_HEIGHT*3], true);
            }
            // remove bottom lip
            translate([0,-PADDING-LIP_HEIGHT/2,0]) {
                square([LIP_WIDTH, LIP_HEIGHT], true);
            }
            
        }
        translate([LIP_WIDTH/2,-PADDING*3,0]) {
            square([LIP_GAP, PADDING*3], false);
        }
        translate([0,PADDING+PADDING/2,0]) {
            square([PADDING,LIP_HEIGHT/4+2*PADDING], true);
        }
    }
}

module support() {
    union() {
        lip();
        
        translate([LIP_WIDTH+PADDING+LIP_GAP,0,0]) {
            mirror([1,0,0]){
                lip();
            }
        }
    }
}



module component(depth=DEPTH) {
    // Create depth
    linear_extrude(height = depth, center = true) {
        // Create the support structure.
        translate([-LIP_WIDTH/2,0,0]) {
            support();
        }
        // Right hook
        mirror([1,0,0]) {
            translate([-PADDING,-HOOK_HEIGHT,0]) {
                hook();
            }
        }
        // Left hook
        translate([LIP_GAP,-HOOK_HEIGHT,0]) {
            hook();
        }
    }
}


component();
