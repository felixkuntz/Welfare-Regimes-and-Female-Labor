clear all
capture log close
log using "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_reg.log", replace


import excel "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_reg.xlsx", sheet("Data") firstrow clear


*Create Welfare Regime dummies
gen welfare_dummy = . 
replace welfare_dummy = 1 if Welfare=="soc"
replace welfare_dummy = 2 if Welfare=="lib"
replace welfare_dummy = 3 if Welfare=="con"
label define welfare_label 1 "social-democratic" 2 "liberal" 3 "conservative"
label values welfare_dummy welfare_label



*Chapter 4 Comparative Empirical Analysis

*Regression with welfare dummies
reg FLFP ib3.welfare_dummy
estimates store reg1
esttab reg1

gen logFLFP = log(FLFP)
reg logFLFP ib3.welfare_dummy

reg decom ib2.welfare_dummy 
estimates store reg2
esttab

reg strat ib1.welfare_dummy 
estimates store reg3
esttab reg1 reg2 reg3


*Figures
graph bar (asis) decom strat, over(Country, sort(strat)) bargap(5)

graph bar (mean) decom, over(welfare_dummy, sort(decom)) xsize(8) ysize(3) bargap(5) name(g_mean1, replace) nodraw
graph bar (mean) strat, over(welfare_dummy, sort(decom)) xsize(8) ysize(3) bargap(5) name(g_mean2, replace) nodraw

graph combine g_mean1 g_mean2, name(mean, replace) xsize(8)

graph bar (asis) decom, over(Country, sort(decom)) xsize(8) ysize(4) bargap(5) title("Degree of De-commodification")
graph bar (asis) strat, over(Country, sort(strat)) xsize(8) ysize(3) bargap(5)
graph bar (asis) strat, over(Country, sort(strat)) xsize(8) ysize(3) bargap(5)

reg decom strat

graph twoway (lfit decom strat, title("De-commodification and Stratification") xtitle("Degree of Stratification") ytitle("Degree of De-commodification")) || (scatter decom strat if Welfare=="con", mlabel(Country)) || (scatter decom strat if Welfare=="soc", mlabel(Country)) || (scatter decom strat if Welfare=="lib", mlabel(Country))

graph twoway (lfit FLFP decom, title("FLFP and De-commodification")) || (scatter FLFP decom if Welfare=="con", mlabel(Country)) || (scatter FLFP decom if Welfare=="soc", mlabel(Country)) || (scatter FLFP decom if Welfare=="lib", mlabel(Country))

graph twoway (lfit FLFP strat, title("FLFP and Stratification")) || (scatter FLFP strat if Welfare=="con", mlabel(Country)) || (scatter FLFP strat if Welfare=="soc", mlabel(Country)) || (scatter FLFP strat if Welfare=="lib", mlabel(Country))


*Chapter 4.1 Maternity Leave

*Parental leave paid
reg FLFP leave
cor FLFP leave
graph twoway (lfit FLFP leave, title("FLFP and Paid Maternity and Parental Leave")) || (scatter FLFP leave if Welfare=="con", mlabel(Country)) || (scatter FLFP leave if Welfare=="soc", mlabel(Country)) || (scatter FLFP leave if Welfare=="lib", mlabel(Country)), name(leave, replace)

*Leave Father
reg FLFP leave_father
cor FLFP leave_father

graph twoway (lfit FLFP leave_father, title("FLFP and Paid Leave for Fathers")) || (scatter FLFP leave_father if Welfare=="con", mlabel(Country)) || (scatter FLFP leave_father if Welfare=="soc", mlabel(Country)) || (scatter FLFP leave_father if Welfare=="lib", mlabel(Country)), name(leavef, replace)

grc1leg leave leavef, fysize(400) fxsize(400)


*Chapter 4.2 Public Service Provison

*Social spending
reg FLFP social
cor FLFP social
graph twoway (lfit FLFP social, title("FLFP and Social Spending (% of GDP)")) || (scatter FLFP social if Welfare=="con", mlabel(Country)) || (scatter FLFP social if Welfare=="soc", mlabel(Country)) || (scatter FLFP social if Welfare=="lib", mlabel(Country)), name(social, replace)


*Family Benefits
reg FLFP family
cor FLFP family
graph twoway (lfit FLFP family, title("FLFP and Family Benefits")) || (scatter FLFP family if Welfare=="con", mlabel(Country)) || (scatter FLFP family if Welfare=="soc", mlabel(Country)) || (scatter FLFP family if Welfare=="lib", mlabel(Country)), name(family, replace)

grc1leg social family, fysize(400) fxsize(400)

*Childcare
reg FLFP childcare
cor FLFP childcare
graph twoway (lfit FLFP childcare, title("FLFP and Childcare")) || (scatter FLFP childcare if Welfare=="con", mlabel(Country)) || (scatter FLFP childcare if Welfare=="soc", mlabel(Country)) || (scatter FLFP childcare if Welfare=="lib", mlabel(Country)), name(childcare, replace)

*Time in care work
reg FLFP care
cor FLFP care
graph twoway (lfit FLFP care, title("FLFP and Time spent on care work")) || (scatter FLFP care if Welfare=="con", mlabel(Country)) || (scatter FLFP care if Welfare=="soc", mlabel(Country)) || (scatter FLFP care if Welfare=="lib", mlabel(Country)), name(care, replace)

grc1leg childcare care, fysize(400) fxsize(400)


*Chapter 4.3 Taxation
reg FLFP tax_diff
cor FLFP tax_diff
graph twoway (lfit FLFP tax_diff, title("Secondary Earner Tax Disadvantage")) || (scatter FLFP tax_diff if Welfare=="con", mlabel(Country)) || (scatter FLFP tax_diff if Welfare=="soc", mlabel(Country)) || (scatter FLFP tax_diff if Welfare=="lib", mlabel(Country))


*Chapter 4.3 Edcuation
reg FLFP edu
cor FLFP edu
graph twoway (lfit FLFP edu, title("Share of Women with Tertiary Education")) || (scatter FLFP edu if Welfare=="con", mlabel(Country)) || (scatter FLFP edu if Welfare=="soc", mlabel(Country)) || (scatter FLFP edu if Welfare=="lib", mlabel(Country))


*Chapter 4.3 Gender Equality

*Genderindex
reg FLFP SIGI
graph twoway (lfit FLFP SIGI, title("FLFP and Genderindex")) || (scatter FLFP SIGI if Welfare=="con", mlabel(Country)) || (scatter FLFP SIGI if Welfare=="soc", mlabel(Country)) || (scatter FLFP SIGI if Welfare=="lib", mlabel(Country)), name(sigi, replace)

*Gender Wage Gap
reg FLFP wagegap
graph twoway (lfit FLFP wagegap, title("FLFP and Unadjusted Gender Wage Gap")) || (scatter FLFP wagegap if Welfare=="con", mlabel(Country)) || (scatter FLFP wagegap if Welfare=="soc", mlabel(Country)) || (scatter FLFP wagegap if Welfare=="lib", mlabel(Country)), name(wagegap, replace)

grc1leg sigi wagegap, fysize(400) fxsize(400)




save "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_reg.dta", replace

log close
