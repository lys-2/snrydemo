with Interfaces.C; use Interfaces.C;
 
procedure Execute_System is
    function Sys (Arg : Char_Array) return Integer;
    pragma Import(C, Sys, "system");
    Ret_Val : Integer;
begin
    Ret_Val := Sys(To_C("start https://noeight.net/topwg/"));
    Ret_Val := Sys(To_C("start snrydemo.exe"));

end Execute_System;


