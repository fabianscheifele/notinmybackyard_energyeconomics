*Testing the weights of a TWFE regression

use "C:/Users/fabi-/Documents/GitHub/brazil_rejobs/final/wind1to1_final_monthly.dta", clear

twowayfeweights wind_inst_endmonth id_municipio date new_mw_wind, type(feTR)

twowayfeweights total_endmonth id_municipio date new_mw_wind, type(feTR)

twowayfeweights wind_om_endmonth id_municipio date new_mw_wind, type(feTR)





use "C:/Users/fabi-/Documents/GitHub/brazil_rejobs/final/wind1to1_final_annual.dta", clear

twowayfeweights solar_inst_endmonth id_municipio date new_mw_solar, type(feTR)
twowayfeweights total_endmonth id_municipio date new_mw_solar, type(feTR)
twowayfeweights solar_om_endmonth id_municipio date new_mw_solar, type(feTR)

rename new_mw_wind d_wind_post0
*drop lags where all observations are zero (no more observable points in the data)
drop d_wind_post16 d_wind_post17 d_wind_pre3 
reghdfe pib_clean_constant2020_BRL d_wind_pre* d_wind_post*, a(id_municipio ano) cluster(id_municipio)
event_plot, default_look stub_lag(d_wind_post#) stub_lead(d_wind_pre#) together graph_opt(xtitle("Days since the event") ytitle("OLS coefficients") xlabel(-17(1)17) ///
	title("OLS"))	

gen control= 0
replace control=1 if solar_treat_postmatch==0
replace date_t0_solar=. if control==1
eventstudyinteract solar_inst_endmonth d_solar_pre* new_mw_solar d_solar_post*, vce(cluster id_municipio) absorb(id_municipio date) cohort(date_t0_solar) control_cohort (control)

event_plot e(b_iw)#e(V_iw), default_look graph_opt(xtitle("Periods since the event") ytitle("Average causal effect") xlabel(-36(4)36) ///
	title("Sun and Abraham (2020)")) stub_lag(d_solar_post#) stub_lead(d_solar_pre#) together

	// TWFE OLS estimation (which is correct here because of treatment effect homogeneity). Some groups could be binned.
reghdfe solar_inst_endmonth d_solar_pre* new_mw_solar d_solar_post*, a(id_municipio date) cluster(id_municipio)
event_plot, default_look stub_lag(d_solar_post#) stub_lead(d_solar_pre#) together graph_opt(xtitle("Days since the event") ytitle("OLS coefficients") xlabel(-36(4)36) ///
	title("OLS"))

	
	// Estimation with did_imputation of Borusyak et al. (2021)
did_imputation solar_inst_endmonth id_municipio date date_t0_solar, allhorizons pretrend(5)
event_plot, default_look graph_opt(xtitle("Periods since the event") ytitle("Average causal effect") ///
	title("Borusyak et al. (2021) imputation estimator") xlabel(-5(1)5))