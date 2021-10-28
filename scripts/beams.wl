beamLengths={384,192,96,72,48,36,24};
beamsFor[length_]:=First@SortBy[IntegerPartitions[length,All,beamLengths,All],Length]

balance[beams_]:=Module[{stuff,even,odd,halfEven,oddList},
    stuff=Association[Rule@@@Tally[beams]];
    {even,odd}=Lookup[GroupBy[stuff,EvenQ],{True,False},{},Normal];
    halfEven={#1,#2/2}&@@@even;
    oddList=List@@@odd;
    Flatten[ConstantArray@@@Join[halfEven,oddList,halfEven]]
]

showBeams[beams_]:= Module[{usedBeamLengths,usedBeamsCount},
    {usedBeamLengths,usedBeamsCount}=Transpose[Tally[beams]];
    With[{
        beamsRectanglesGroupedByKind=MapThread[ConstantArray,{Thread[{usedBeamLengths,1}],usedBeamsCount}],
        beamGroupLengths=beamsRectanglesGroupedByKind[[All,1,1]],
        beamsRectangles=Thread[{beams,1}],
        labelingFunction=Placed[#1[[1]], Center] &,
        colorFunction=ColorData["Pastel"][#1]&,
        common=Sequence[BarSpacing->None,Axes->{True,False}]
    },
    If[False,
        RectangleChart[beamsRectanglesGroupedByKind,ChartLegends->{usedBeamLengths,None},ChartStyle->{"Pastel",None},common],
        RectangleChart[beamsRectangles,ChartLabels->beams, ColorFunction ->colorFunction,common ]]
    ]
]