{*****************************************************************************
 * Function ...... Timer
 * Purpose ....... Returns the number of seconds since midnight
 * Parameters .... None
 * Returns ....... Number of seconds since midnight to the 100th decimial place
 * Notes ......... None
 * Author ........ Martin Richardson
 * Date .......... May 13, 1992
 *****************************************************************************}
FUNCTION Timer : REAL;
VAR hour,
    minute,
    second,
    sec100  : WORD;
BEGIN
     GETTIME(hour, minute, second, sec100);
     Timer := ((hour*60*60) + (minute*60) + (second) + (sec100 * 0.01))
END;

