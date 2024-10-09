restartKey = keyboard_check(ord("R"))
quitKey = keyboard_check(ord("Q"))

// fade in
alpha += alphaSpd
alpha = clamp(alpha,0,1)

// restart
if (restartKey && alpha >= 1) {

}