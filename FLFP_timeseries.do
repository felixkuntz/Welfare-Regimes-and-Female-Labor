clear all
capture log close
log using "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_timeseries.log", replace


*Import
import excel "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_timeseries.xlsx", sheet("Data") firstrow


*Time Series definition
tsset year, yearly


*Time Series Means Welfare Regimes
gen mean_liberal = (AUS + CAN + USA + NZL + GBR + IRE)/6
gen mean_cons = (AUT + BEL + FRA + GER + ITA + JPN + CHE + NLD)/8
gen mean_socdem = (DNK + FIN + NOR + SWE)/4

twoway (tsline mean_cons)(tsline mean_liberal)(tsline mean_socdem)
twoway (tsline AUS CAN USA NZL GBR IRE)
twoway (tsline AUT BEL FRA GER ITA JPN CHE NLD)
twoway (tsline DNK FIN NOR SWE)


*Time Series Means Welfare Regimes Population Weighted
gen meanpop_liberal = (AUS*popAUS + CAN*popCAN + USA*popUSA + NZL*popNZL+ GBR*popGBR + IRE*popIRE)/(popAUS + popCAN + popUSA + popNZL + popGBR + popIRE)
gen meanpop_cons = (AUT*popAUT + BEL*popBEL + FRA*popFRA + GER*popGER + ITA*popITA + JPN*popJPN + CHE*popCHE + NLD*popNLD)/(popAUT + popBEL + popFRA + popGER + popITA + popJPN + popCHE + popNLD)
gen meanpop_socdem = (DNK*popDNK + FIN*popFIN + NOR*popNOR + SWE*popSWE)/(popDNK + popFIN + popNOR + popSWE)

twoway (tsline meanpop_cons)(tsline meanpop_socdem)(tsline meanpop_liberal)



save "/Users/felixkuntz/Desktop/PoWi 20:21/Work-Family Policies/Paper/FLFP_timeseries.dta", replace

log close

