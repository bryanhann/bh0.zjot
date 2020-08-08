function zjot_now {
    echo `date "+%Y-%m-%d-T-%H:%M:%S"` ;
}
function zjot() {
    [[ -z $ZJOT_ACC ]] && {
        echo "zjot: [\$ZJOT_ACC] is not set"
        return
    }
    touch $ZJOT_ACC
	case .$1 in
		.cat)
			cat $ZJOT_ACC
			;;
		.norm)
			cat $ZJOT_ACC | sed 's!\([:T0-9\-]*\)*!& [zjot]!'
			;;
		.new)
			tail $ZJOT_ACC
			echo -------------------------------------
			echo -n \>
			read LINE
            [[ "$LINE" == "" ]] || echo $(zjot_now) "$LINE" >> $ZJOT_ACC
			tail $ZJOT_ACC
			echo -------------------------------------
			echo log written at $ZJOT_ACC
			;;
		.*)
			echo "zjot -- a note taking and retrieval system."
			echo "usage:"
			echo "    zjot cat"
			echo "    zjot norm"
			echo "    zjot new"
			;;
	esac
}
