# xdotool windowactivate $starbase
# xdotool key --window $starbase Return
# xdotool click --window $starbase 1
frame=0.03
type() {
    echo "type $1"
    xdotool key Control_L+A
    xdotool keydown ctrl+A
    sleep $frame
    xdotool keyup ctrl+A

    xdotool type $1
    xdotool keydown Down
    sleep frame
    xdotool keyup Down
}

clip=`xclip -o -selection clipboard`
IFS=$'\n'
for line in $clip
do
echo $line
done