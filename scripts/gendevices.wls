#!/usr/bin/env wolframscript
ToPascalCase=Capitalize@*ResourceFunction["ToCamelCase"]@*StringReplace["_"->" "];
unParse=Flatten@*ReplaceRepeated[{
region[name_String, body_]:>{comment["#region "<>name],body,comment["#endregion"]},
define[thing_String,as_String]:>{"define "<>thing<>"="<>as},
comment[comment_String]:>"//"<>comment
}]

ClearAll[unParse]
unParse[region[name_String, body_]]:=unParse@{
comment["#region "<>name],body,comment["#endregion"]
}
unParse[x_String]:=x
unParse[define[thing_String,as_]]:={"define "<>thing<>"="<>unParse[as]}
unParse[comment[comment_String]]:="//"<>comment
(*unParse[x_List]:=unParse/@x*)
Attributes[unParse]={Listable};


urls=Import["https://wiki.starbasegame.com/index.php/Category:Devices_and_machines",{"HTML","Hyperlinks"}];
urls=Select[urls,StringContainsQ["https://wiki.starbasegame.com/index.php/"]];
urls=Select[urls,Not@*StringContainsQ[")"]];
urls=Select[urls,Not@*StringContainsQ["Guide"]];
urls=Select[urls,Not@*AnyTrue[StringContainsQ[":"]]@*Lookup["Path"]@*URLParse];

Print["Num Urls", Length[urls]]
getCodeFor[url_]:=Block[{data,tables,deviceName,code,cache},
    cache = LocalCache[URL[url]];
    data=Import[cache,"Data"];
    deviceName=ToPascalCase@Last[URLParse[url]["Path"]];
    tables=Cases[data,{{"YOLOL field",__},x__}:>{x},Infinity];
    code=Table[
            region[deviceName,
            Table[
                Block[{name, description, range,fullName},
                    {name, description, range}=PadRight[StringTrim@*ToString/@Flatten[{row}],3,""]~Take~3;
                    {
                    comment[If[range!="", description<>" Range: "<>range, description]],
                    define[deviceName<>"_"<>name,":"<>name]
                    }
                    ],
                {row,table}]],
            {table,tables}];
    Print[url -> code];
    code
]

code=Table[StringRiffle[Flatten@unParse@getCodeFor[url],"\n"],{url,urls}];
Print["Combining"];
codeStr=StringRiffle[DeleteCases[code,""],"\n\n"];
Print["write out"];
WriteString["devices.nolol", codeStr]
