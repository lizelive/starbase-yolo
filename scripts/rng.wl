fixed=1000;
m=1000;
seedRange={fixed,fixed*10-1};
aMul=LCM[Times@@(FactorInteger[m][[All,1]]),GCD[m,4]];

Table[
c=RandomPrime[seedRange];
seed2=RandomInteger[Quotient[seedRange,aMul]];
a=(seed2*aMul+1)*fixed;
lcm=x|->Mod [Quotient[a*x,fixed] + c,m];
cycle=NestList[lcm,0,m];
pcst=PearsonChiSquareTest[LowpassFilter[N@cycle,2]]+PearsonChiSquareTest[HighpassFilter[N@cycle,2]];
values=Length@Tally[ cycle];
{a,c}/1000.->{values,pcst,ListLinePlot[cycle]}
,10]