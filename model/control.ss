#V3.30.22.1;_safe;_compile_date:_Jan 30 2024;_Stock_Synthesis_by_Richard_Methot_(NOAA)_using_ADMB_13.1
#_Stock_Synthesis_is_a_work_of_the_U.S._Government_and_is_not_subject_to_copyright_protection_in_the_United_States.
#_Foreign_copyrights_may_apply._See_copyright.txt_for_more_information.
#_User_support_available_at:NMFS.Stock.Synthesis@noaa.gov
#_User_info_available_at:https://vlab.noaa.gov/group/stock-synthesis
#_Source_code_at:_https://github.com/nmfs-ost/ss3-source-code

#C control file for crab (wales)
#_data_and_control_files: data.ss // control.ss
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and also read and use growth parameters
1  #_N_Growth_Patterns (Growth Patterns, Morphs, Bio Patterns, GP are terms used interchangeably in SS3)
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Platoon_within/between_stdev_ratio (no read if N_platoons=1)
#_Cond sd_ratio_rd < 0: platoon_sd_ratio parameter required after movement params.
#_Cond  1 #vector_platoon_dist_(-1_in_first_val_gives_normal_approx)
#
4 # recr_dist_method for parameters:  2=main effects for GP, Area, Settle timing; 3=each Settle entity; 4=none (only when N_GP*Nsettle*pop==1)
1 # not yet implemented; Future usage: Spawner-Recruitment: 1=global; 2=by area
1 #  number of recruitment settlement assignments 
0 # unused option
#GPattern month  area  age (for each settlement assignment)
 1 7.5 1 0
#
#_Cond 0 # N_movement_definitions goes here if Nareas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1 dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 1 2 #_blocks_per_pattern 
# begin and end years of blocks
 1983 1992
 1986 1993 1994 2034
#
# controls for all timevary parameters 
1 #_time-vary parm bound check (1=warn relative to base parm bounds; 3=no bound check); Also see env (3) and dev (5) options to constrain with base bounds
#
# AUTOGEN
 1 1 1 1 1 # autogen: 1st element for biology, 2nd for SR, 3rd for Q, 4th reserved, 5th for selex
# where: 0 = autogen time-varying parms of this category; 1 = read each time-varying parm line; 2 = read then autogen if parm min==-12345
#
#_Available timevary codes
#_Block types: 0: P_block=P_base*exp(TVP); 1: P_block=P_base+TVP; 2: P_block=TVP; 3: P_block=P_block(-1) + TVP
#_Block_trends: -1: trend bounded by base parm min-max and parms in transformed units (beware); -2: endtrend and infl_year direct values; -3: end and infl as fraction of base range
#_EnvLinks:  1: P(y)=P_base*exp(TVP*env(y));  2: P(y)=P_base+TVP*env(y);  3: P(y)=f(TVP,env_Zscore) w/ logit to stay in min-max;  4: P(y)=2.0/(1.0+exp(-TVP1*env(y) - TVP2))
#_DevLinks:  1: P(y)*=exp(dev(y)*dev_se;  2: P(y)+=dev(y)*dev_se;  3: random walk;  4: zero-reverting random walk with rho;  5: like 4 with logit transform to stay in base min-max
#_DevLinks(more):  21-25 keep last dev for rest of years
#
#_Prior_codes:  0=none; 6=normal; 1=symmetric beta; 2=CASAL's beta; 3=lognormal; 4=lognormal with biascorr; 5=gamma
#
# setup for M, growth, wt-len, maturity, fecundity, (hermaphro), recr_distr, cohort_grow, (movement), (age error), (catch_mult), sex ratio 
#_NATMORT
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agespec_withseasinterpolate;_5=BETA:_Maunder_link_to_maturity;_6=Lorenzen_range
  #_no additional input for selected M option; read 1P per morph
#
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specific_K_incr; 4=age_specific_K_decr; 5=age_specific_K_each; 6=NA; 7=NA; 8=growth cessation
1 #_Age(post-settlement) for L1 (aka Amin); first growth parameter is size at this age; linear growth below this
999 #_Age(post-settlement) for L2 (aka Amax); 999 to treat as Linf
-999 #_exponential decay for growth above maxage (value should approx initial Z; -999 replicates 3.24; -998 to not allow growth above maxage)
0  #_placeholder for future growth feature
#
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 logSD=F(A)
#
1 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturity matrix by growth_pattern; 4=read age-fecundity; 5=disabled; 6=read length-maturity
5 #_First_Mature_Age
2 #_fecundity_at_length option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)eggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=male-to-female age-specific fxn
1 #_parameter_offset_approach for M, G, CV_G:  1- direct, no offset**; 2- male=fem_parm*exp(male_parm); 3: male=female*exp(parm) then old=young*exp(parm)
#_** in option 1, any male parameter with value = 0.0 and phase <0 is set equal to female parameter
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev_maxyr dev_PH Block Block_Fxn
# Sex: 1  BioPattern: 1  NatMort
 0.05 2.4 0.420811 0.369077 99 0 -1 0 0 0 0 0 0 0 # NatM_uniform_Fem_GP_1
# Sex: 1  BioPattern: 1  Growth
 3 10 5.67175 5 99 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 5 30 19.1493 20.34 99 0 -3 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.1 2 0.396289 0.3 99 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.01 0.4 0.0544308 0.03 99 0 -3 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.001 0.9 0.112151 0.15 99 0 -3 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
# Sex: 1  BioPattern: 1  WtLen
 -3 3 0.00017419 0.00017419 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Fem_GP_1
 -3 4 2.94 2.94 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Fem_GP_1
# Sex: 1  BioPattern: 1  Maturity&Fecundity
 5 15 11.4 11.4 99 0 -99 0 0 0 0 0 0 0 # Mat50%_Fem_GP_1
 -5 0 -1.5 -1.5 99 0 -99 0 0 0 0 0 0 0 # Mat_slope_Fem_GP_1
 -3 10 1 1 99 0 -99 0 0 0 0 0 0 0 # Eggs_scalar_Fem_GP_1
 -3 10 0 0 99 0 -99 0 0 0 0 0 0 0 # Eggs_exp_len_Fem_GP_1
# Sex: 2  BioPattern: 1  NatMort
 0.05 2.4 0.562392 0.525191 99 0 -1 0 0 0 0 0 0 0 # NatM_uniform_Mal_GP_1
# Sex: 2  BioPattern: 1  Growth
 3 10 5.86105 5 99 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 5 30 22.3158 23.85 99 0 -3 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 0.05 2 0.261108 0.28 99 0 -3 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 0.01 0.4 0.163142 0.2 99 0 -3 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 0.001 0.9 0.0218258 0.01 99 0 -3 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
# Sex: 2  BioPattern: 1  WtLen
 -3 2 0.0002143 0.0002143 99 0 -99 0 0 0 0 0 0 0 # Wtlen_1_Mal_GP_1
 -3 5 3.03 3.03 99 0 -99 0 0 0 0 0 0 0 # Wtlen_2_Mal_GP_1
# Hermaphroditism
#  Recruitment Distribution 
#  Cohort growth dev base
 0.1 10 1 1 1 0 -1 0 0 0 0 0 0 0 # CohortGrowDev
#  Movement
#  Platoon StDev Ratio 
#  Age Error from parameters
#  catch multiplier
 0 1 0.680684 0.8 3 1 1 0 1 1983 2005 1 0 0 # Catch_Mult:_2_Pot_fisheries_historical
 0 3 1.36626 0.8 3 1 1 0 1 1983 2005 1 0 0 # Catch_Mult:_6_Bycatch_fisheries_historical
#  fraction female, by GP
 1e-06 0.999999 0.5 0.5 0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#  M2 parameter for each predator fleet
#
# timevary MG parameters 
#_ LO HI INIT PRIOR PR_SD PR_type  PHASE
 0 1 0.597932 0.5 3 1 5 # Catch_Mult:_2_Pot_fisheries_historical_dev_se
 -5 5 -5.36067e-07 1 3 1 6 # Catch_Mult:_2_Pot_fisheries_historical_dev_autocorr
 0 1 0.500973 0.5 3 1 5 # Catch_Mult:_6_Bycatch_fisheries_historical_dev_se
 -5 5 -5.36067e-07 1 3 1 6 # Catch_Mult:_6_Bycatch_fisheries_historical_dev_autocorr
# info on dev vectors created for MGparms are reported with other devs after tag parameter section 
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,malewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
3 #_Spawner-Recruitment; Options: 1=NA; 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=survival_3Parm; 8=Shepherd_3Parm; 9=RickerPower_3parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvature
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn #  parm_name
             1            20       8.97681           9.1            99             6          1          0          0          0          0          0          0          0 # SR_LN(R0)
           0.1             1      0.818838           0.7             3             1          5          0          0          0          0          0          0          0 # SR_BH_steep
             0             8         1.377             2            99             0         -2          0          0          0          0          0          0          0 # SR_sigmaR
            -5             5             0             0            99             0         -1          0          0          0          0          0          0          0 # SR_regime
             0             1             0         0.456            99             0         -2          0          0          0          0          0          0          0 # SR_autocorr
#_no timevary SR parameters
3 #do_recdev:  0=none; 1=devvector (R=F(SSB)+dev); 2=deviations (R=F(SSB)+dev); 3=deviations (R=R0*dev; dev2=R-f(SSB)); 4=like 3 with sum(dev2) adding penalty
1983 # first year of main recr_devs; early devs can precede this era
2024 # last year of main recr_devs; forecast devs start in following year
3 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1947 #_recdev_early_start (0=none; neg value makes relative to recdev_start)
 4 #_recdev_early_phase
 -1 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxphase+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1975 #_last_yr_nobias_adj_in_MPD; begin of ramp
 1980 #_first_yr_fullbias_adj_in_MPD; begin of plateau
 2022 #_last_yr_fullbias_adj_in_MPD
 2023 #_end_yr_for_ramp_in_MPD (can be in forecast to shape ramp, but SS3 sets bias_adj to 0.0 for fcast yrs)
 0.9649 #_max_bias_adj_in_MPD (typical ~0.8; -3 sets all years to 0.0; -2 sets all non-forecast yrs w/ estimated recdevs to 1.0; -1 sets biasadj=1.0 for all yrs w/ recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -5 #min rec_dev
 5 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1947E 1948E 1949E 1950E 1951E 1952E 1953E 1954E 1955E 1956E 1957E 1958E 1959E 1960E 1961E 1962E 1963E 1964E 1965E 1966E 1967E 1968E 1969E 1970E 1971E 1972E 1973E 1974E 1975E 1976E 1977E 1978E 1979E 1980E 1981E 1982E 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R 2005R 2006R 2007R 2008R 2009R 2010R 2011R 2012R 2013R 2014R 2015R 2016R 2017R 2018R 2019R 2020R 2021R 2022R 2023R 2024R 2025F 2026F 2027F 2028F 2029F 2030F 2031F 2032F 2033F 2034F
#  -2.01744e-05 -1.241e-05 -2.02854e-05 -3.3113e-05 -5.57155e-05 -9.91791e-05 -0.000190715 -0.000394645 -0.000869892 -0.00197399 -0.00442969 -0.00772377 -0.0115556 -0.0156001 -0.0211002 -0.0457054 -0.0518241 -0.062481 -0.0793861 -0.103759 -0.137667 -0.182899 -0.242837 -0.319974 -0.416521 -0.53562 -0.676042 -0.828429 -0.986219 -1.16419 -1.20075 -0.939373 0.0547905 -1.09339 -0.592941 -0.943824 -1.21967 -1.64933 0.54278 0.0170254 0.78345 -1.66228 0.398654 -0.966416 -1.63127 -0.654018 0.478112 0.116681 -0.784209 -0.118428 -0.769028 -0.23355 0.00489539 -0.562372 -1.17527 -1.76436 -0.501656 -1.21093 0.226769 -0.422778 0.177984 0.0600729 -0.0433888 -0.461424 -0.113488 -0.118029 -0.601334 0.112843 -0.623185 -1.72697 -0.343197 -0.719444 -0.744266 -1.06108 -0.368661 -0.115497 -0.149822 -0.20651 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.4 # F ballpark value in units of annual_F
-2008 # F ballpark year (neg value to disable)
4 # F_Method:  1=Pope midseason rate; 2=F as parameter; 3=F as hybrid; 4=fleet-specific parm/hybrid (#4 is superset of #2 and #3 and is recommended)
7 # max F (methods 2-4) or harvest fraction (method 1)
# read list of fleets that do F as parameter; unlisted fleets stay hybrid, bycatch fleets must be included with start_PH=1, high F fleets should switch early
# (A) fleet, (B) F_starting_value (used if start_PH=1), (C) start_PH for parms (99 to stay in hybrid, <0 to stay at starting value)
# (A) (B) (C)  (terminate list with -9999 for fleet)
 2 0.3 99 # Pot_fisheries_historical
 3 0.3 99 # Pot_fisheries_u10
 4 0.3 99 # Pot_fisheries_10to12
 5 0.3 99 # Pot_fisheries_o12
 6 0.1 99 # Bycatch_fisheries_historical
 7 0.1 99 # Bycatch_fisheries_gillnet
 8 0.1 99 # Bycatch_fisheries_trawl
-9999 1 1 # end of list
7 #_number of loops for hybrid tuning; 4 good; 3 faster; 2 enough if switching to parms is enabled
#
#_initial_F_parms; for each fleet x season that has init_catch; nest season in fleet; count = 2
#_for unconstrained init_F, use an arbitrary initial catch and set lambda=0 for its logL
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
 0.01 5 0.250668 0.5 3 1 1 # InitF_seas_1_flt_2Pot_fisheries_historical
 0 0.2 0.044062 0.03 3 1 1 # InitF_seas_1_flt_6Bycatch_fisheries_historical
#
# F rates by fleet x season
# Yr:  1962 1963 1964 1965 1966 1967 1968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982 1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022 2023 2024 2025 2026 2027 2028 2029 2030 2031 2032 2033 2034
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
# Pot_fisheries_historical 0.0122143 0.0153334 0.0156615 0.0182812 0.0180967 0.0171712 0.0183976 0.0215042 0.0158113 0.0192299 0.0127725 0.0168402 0.0210128 0.0290127 0.109672 0.0841337 0.0617817 1.03811 0.157973 0.730674 0.280925 0.344608 0.112235 0.212796 0.216276 0.711447 0.751293 1.35672 0.845572 0.735365 1.13588 0.329584 0.255406 0.757254 0.250753 1.97662 1.47677 1.24245 1.13138 1.5976 1.89936 1.4266 1.37051 2.48707 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# Pot_fisheries_u10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 5.59007 6.28297 4.82783 2.5811 3.06727 3.29619 2.59983 1.55154 1.39393 1.0989 1.2596 1.89949 1.5634 1.63761 1.45179 1.31026 1.1349 1.08211 1.31488 0.548421 0.862858 0.969936 0.969936 0.969936 0.969936 0.969936 0.969936 0.969936 0.969936
# Pot_fisheries_10to12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.485196 0.469827 0.203252 0.536761 0.904455 1.08834 1.31728 0.598591 0.534719 0.479174 0.398987 0.322835 0.414315 0.973164 0.80705 0.615782 0.52866 0.563946 0.26051 0.222997 0.350853 0.394393 0.394393 0.394393 0.394393 0.394393 0.394393 0.394393 0.394393
# Pot_fisheries_o12 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.000589977 0.00996925 0.00773289 0.607224 0.909676 0.0633596 0.049163 0.0292771 0.141824 0.251388 0.165035 0.647908 0.463646 0.174429 0.17957 0.238725 0.25986 0.385436 0.418266 0.147497 0.232065 0.260863 0.260863 0.260863 0.260863 0.260863 0.260863 0.260863 0.260863
# Bycatch_fisheries_historical 0.019653 0.0186708 0.0180589 0.0177618 0.0176466 0.0176379 0.0177236 0.0179155 0.0182166 0.0186588 0.0192828 0.0201493 0.0213557 0.0230111 0.0254511 0.0287302 0.0326663 0.0415639 0.0518026 0.055517 0.0408662 0.039471 0.0390553 0.0401803 0.0451539 0.0559865 0.0335144 0.0276498 0.0202284 0.0226565 0.0228821 0.025987 0.0323154 0.0379606 0.0271431 0.0241313 0.0296411 0.0324458 0.0367144 0.0382795 0.0356103 0.0380764 0.0481184 0.0776783 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# Bycatch_fisheries_gillnet 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0133709 0.0154388 0.0294241 0.0209597 0.0212594 0.0167229 0.0221971 0.0246006 0.0162703 0.00441677 0.0106008 0.00613647 0.00256535 0.00739691 0.00345284 0.00520643 0.0124919 0.00925961 0.00698758 0.00384467 0.00604901 0.00679967 0.00679967 0.00679967 0.00679967 0.00679967 0.00679967 0.00679967 0.00679967
# Bycatch_fisheries_trawl 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0.0723482 0.0858987 0.0505327 0.0555677 0.0551239 0.050591 0.0678923 0.0572554 0.0422862 0.0391662 0.045909 0.0367545 0.0307843 0.0336223 0.0376798 0.0145325 0.00312933 0.00529121 0.00856825 0.0035701 0.00561702 0.00631408 0.00631408 0.00631408 0.00631408 0.00631408 0.00631408 0.00631408 0.00631408
#
#_Q_setup for fleets with cpue or survey data
#_1:  fleet number
#_2:  link type: (1=simple q, 1 parm; 2=mirror simple q, 1 mirrored parm; 3=q and power, 2 parm; 4=mirror with offset, 2 parm)
#_3:  extra input for link, i.e. mirror fleet# or dev index number
#_4:  0/1 to select extra sd parameter
#_5:  0/1 for biasadj or not
#_6:  0/1 to float
#_   fleet      link link_info  extra_se   biasadj     float  #  fleetname
         3         1         0         1         1         1  #  Pot_fisheries_u10
         4         1         0         1         1         1  #  Pot_fisheries_10to12
         5         1         0         1         1         1  #  Pot_fisheries_o12
         7         1         0         1         1         1  #  Bycatch_fisheries_gillnet
         8         1         0         1         1         1  #  Bycatch_fisheries_trawl
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
           -50            15       -6.5185           -15             1             1         -1          0          0          0          0          0          0          0  #  LnQ_base_Pot_fisheries_u10(3)
             0             1      0.419271           0.5             1             1          3          0          0          0          0          0          0          0  #  Q_extraSD_Pot_fisheries_u10(3)
           -50            50       -7.2272            -5             1             1         -1          0          0          0          0          0          0          0  #  LnQ_base_Pot_fisheries_10to12(4)
             0             3      0.198228          0.02             1             1          3          0          0          0          0          0          0          0  #  Q_extraSD_Pot_fisheries_10to12(4)
           -50            15      -6.94731           -15             1             1         -1          0          0          0          0          0          0          0  #  LnQ_base_Pot_fisheries_o12(5)
             0             1      0.145532           0.5             1             1          3          0          0          0          0          0          0          0  #  Q_extraSD_Pot_fisheries_o12(5)
           -50            30      -6.72294             1             1             1         -1          0          0          0          0          0          0          0  #  LnQ_base_Bycatch_fisheries_gillnet(7)
             0             5      0.141179          0.02             1             1          3          0          0          0          0          0          0          0  #  Q_extraSD_Bycatch_fisheries_gillnet(7)
           -50            15      -7.65361           -12             1             1         -1          0          0          0          0          0          0          0  #  LnQ_base_Bycatch_fisheries_trawl(8)
             0             1     0.0219258          0.02             1             1          3          0          0          0          0          0          0          0  #  Q_extraSD_Bycatch_fisheries_trawl(8)
#_no timevary Q parameters
#
#_size_selex_patterns
#Pattern:_0;  parm=0; selex=1.0 for all sizes
#Pattern:_1;  parm=2; logistic; with 95% width specification
#Pattern:_5;  parm=2; mirror another size selex; PARMS pick the min-max bin to mirror
#Pattern:_11; parm=2; selex=1.0  for specified min-max population length bin range
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_6;  parm=2+special; non-parm len selex
#Pattern:_43; parm=2+special+2;  like 6, with 2 additional param for scaling (mean over bin range)
#Pattern:_8;  parm=8; double_logistic with smooth transitions and constant above Linf option
#Pattern:_9;  parm=6; simple 4-parm double logistic with starting length; parm 5 is first length; parm 6=1 does desc as offset
#Pattern:_21; parm=2+special; non-parm len selex, read as pairs of size, then selex
#Pattern:_22; parm=4; double_normal as in CASAL
#Pattern:_23; parm=6; double_normal where final value is directly equal to sp(6) so can be >1.0
#Pattern:_24; parm=6; double_normal with sel(minL) and sel(maxL), using joiners
#Pattern:_2;  parm=6; double_normal with sel(minL) and sel(maxL), using joiners, back compatibile version of 24 with 3.30.18 and older
#Pattern:_25; parm=3; exponential-logistic in length
#Pattern:_27; parm=special+3; cubic spline in length; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=special+3+2; cubic spline; like 27, with 2 additional param for scaling (mean over bin range)
#_discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_discarded_dead;_4=define_dome-shaped_retention
#_Pattern Discard Male Special
 24 2 2 0 # 1 Observer_inshore_u10
 24 2 2 0 # 2 Pot_fisheries_historical
 24 2 2 0 # 3 Pot_fisheries_u10
 15 0 0 3 # 4 Pot_fisheries_10to12
 15 0 0 2 # 5 Pot_fisheries_o12
 23 0 0 0 # 6 Bycatch_fisheries_historical
 15 0 0 6 # 7 Bycatch_fisheries_gillnet
 15 0 0 6 # 8 Bycatch_fisheries_trawl
#
#_age_selex_patterns
#Pattern:_0; parm=0; selex=1.0 for ages 0 to maxage
#Pattern:_10; parm=0; selex=1.0 for ages 1 to maxage
#Pattern:_11; parm=2; selex=1.0  for specified min-max age
#Pattern:_12; parm=2; age logistic
#Pattern:_13; parm=8; age double logistic. Recommend using pattern 18 instead.
#Pattern:_14; parm=nages+1; age empirical
#Pattern:_15; parm=0; mirror another age or length selex
#Pattern:_16; parm=2; Coleraine - Gaussian
#Pattern:_17; parm=nages+1; empirical as random walk  N parameters to read can be overridden by setting special to non-zero
#Pattern:_41; parm=2+nages+1; // like 17, with 2 additional param for scaling (mean over bin range)
#Pattern:_18; parm=8; double logistic - smooth transition
#Pattern:_19; parm=6; simple 4-parm double logistic with starting age
#Pattern:_20; parm=6; double_normal,using joiners
#Pattern:_26; parm=3; exponential-logistic in age
#Pattern:_27; parm=3+special; cubic spline in age; parm1==1 resets knots; parm1==2 resets all 
#Pattern:_42; parm=2+special+3; // cubic spline; with 2 additional param for scaling (mean over bin range)
#Age patterns entered with value >100 create Min_selage from first digit and pattern from remainder
#_Pattern Discard Male Special
 0 0 0 0 # 1 Observer_inshore_u10
 0 0 0 1 # 2 Pot_fisheries_historical
 0 0 0 1 # 3 Pot_fisheries_u10
 0 0 0 1 # 4 Pot_fisheries_10to12
 0 0 0 1 # 5 Pot_fisheries_o12
 0 0 0 1 # 6 Bycatch_fisheries_historical
 0 0 0 1 # 7 Bycatch_fisheries_gillnet
 0 0 0 1 # 8 Bycatch_fisheries_trawl
#
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type      PHASE    env-var    use_dev   dev_mnyr   dev_mxyr     dev_PH      Block    Blk_Fxn  #  parm_name
# 1   Observer_inshore_u10 LenSelex
             5            22       14.9341            18             3             1          1          0          0          0          0          0          0          0  #  Size_DblN_peak_Observer_inshore_u10(1)
           -30             4           -13            -1             3             1          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Observer_inshore_u10(1)
           -30            30       1.90278             6            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Observer_inshore_u10(1)
           -50            50       14.8814            15            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Observer_inshore_u10(1)
           -35             9          -999            -5            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Observer_inshore_u10(1)
           -90             5         -42.5           -30             1             1          3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Observer_inshore_u10(1)
            11            20          15.5            13             3             1          2          0          0          0          0          0          2          2  #  Retain_L_infl_Observer_inshore_u10(1)
          0.01            50        25.005             5             3             1          2          0          0          0          0          0          2          2  #  Retain_L_width_Observer_inshore_u10(1)
           -50           100       10.0542            10            99             6          3          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_Observer_inshore_u10(1)
           -50            50      0.992217             1            99             6          3          0          0          0          0          0          2          2  #  Retain_L_maleoffset_Observer_inshore_u10(1)
             0            15             0             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_infl_Observer_inshore_u10(1)
             0            10     0.0827097             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_Observer_inshore_u10(1)
             0             1    0.00050554          0.01            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_level_old_Observer_inshore_u10(1)
           -10            50       1.00916             1            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_Observer_inshore_u10(1)
             1            30       19.6901            10             1             1          4          0          0          0          0          0          0          0  #  SzSel_MaleDogleg_Observer_inshore_u10(1)
           -30            30      -2.73581           0.5             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatZero_Observer_inshore_u10(1)
           -20            20     -0.731553           0.5            99             6          4          0          0          0          0          0          0          0  #  SzSel_MaleatDogleg_Observer_inshore_u10(1)
           -50            10      -19.5006           -10             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatMaxage_Observer_inshore_u10(1)
# 2   Pot_fisheries_historical LenSelex
             4            23       15.3394          14.5             1             1          1          0          0          0          0          0          0          0  #  Size_DblN_peak_Pot_fisheries_historical(2)
           -20            30       1.43335            -1             1             1          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Pot_fisheries_historical(2)
           -50            50        1.3738             6            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Pot_fisheries_historical(2)
           -50            80      -2.70153             5            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Pot_fisheries_historical(2)
           -50            50          -999            -5            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Pot_fisheries_historical(2)
           -90             5         -42.5           -10             3             1          3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Pot_fisheries_historical(2)
            11            20       15.5316            13             3             1          2          0          0          0          0          0          2          2  #  Retain_L_infl_Pot_fisheries_historical(2)
             0           100       49.1823            10             3             1          2          0          0          0          0          0          2          2  #  Retain_L_width_Pot_fisheries_historical(2)
           -50            90            20            10             3             1          3          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_Pot_fisheries_historical(2)
           -90            90       11.6644             1             3             1          3          0          0          0          0          0          2          2  #  Retain_L_maleoffset_Pot_fisheries_historical(2)
             0            15             0             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_infl_Pot_fisheries_historical(2)
             0            10     0.0827097             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_Pot_fisheries_historical(2)
             0             1    0.00050554          0.01            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_level_old_Pot_fisheries_historical(2)
           -10            50       1.00916             1            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_Pot_fisheries_historical(2)
             1            22         11.75          11.8             1             1         -4          0          0          0          0          0          0          0  #  SzSel_MaleDogleg_Pot_fisheries_historical(2)
           -90            30      -31.1569           0.5             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatZero_Pot_fisheries_historical(2)
           -20            22     -0.522574           0.5            99             6          4          0          0          0          0          0          0          0  #  SzSel_MaleatDogleg_Pot_fisheries_historical(2)
           -50            30      -1.95499            -2             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatMaxage_Pot_fisheries_historical(2)
# 3   Pot_fisheries_u10 LenSelex
             5            22       19.5465          14.5             1             1          1          0          0          0          0          0          0          0  #  Size_DblN_peak_Pot_fisheries_u10(3)
           -50            50        -1.081          -0.2             3             1          3          0          0          0          0          0          0          0  #  Size_DblN_top_logit_Pot_fisheries_u10(3)
           -50            80       2.29559           0.2            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_ascend_se_Pot_fisheries_u10(3)
           -50            50       9.90664            10            99             6          3          0          0          0          0          0          0          0  #  Size_DblN_descend_se_Pot_fisheries_u10(3)
           -35             9          -999            -5            99             0        -99          0          0          0          0          0          0          0  #  Size_DblN_start_logit_Pot_fisheries_u10(3)
           -30             5         -12.5           -15             3             1          3          0          0          0          0          0          0          0  #  Size_DblN_end_logit_Pot_fisheries_u10(3)
            11            23            17            13             3             1          2          0          0          0          0          0          2          2  #  Retain_L_infl_Pot_fisheries_u10(3)
             0           150            75             5             3             1          2          0          0          0          0          0          2          2  #  Retain_L_width_Pot_fisheries_u10(3)
           -50            50       9.91904            10            99             6          3          0          0          0          0          0          2          2  #  Retain_L_asymptote_logit_Pot_fisheries_u10(3)
           -30            90       1.20372             1            99             6          3          0          0          0          0          0          2          2  #  Retain_L_maleoffset_Pot_fisheries_u10(3)
             0            15             0             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_infl_Pot_fisheries_u10(3)
             0            10     0.0827097             0            99             0         -4          0          0          0          0          0          0          0  #  DiscMort_L_width_Pot_fisheries_u10(3)
             0             1    0.00050554          0.01            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_level_old_Pot_fisheries_u10(3)
           -10            10       1.00916             1            99             0         -5          0          0          0          0          0          0          0  #  DiscMort_L_male_offset_Pot_fisheries_u10(3)
             1            50       14.5432            16            99             6          4          0          0          0          0          0          0          0  #  SzSel_MaleDogleg_Pot_fisheries_u10(3)
           -30            30      -4.49347           0.5             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatZero_Pot_fisheries_u10(3)
           -20            50       1.12398          0.01            99             6          4          0          0          0          0          0          0          0  #  SzSel_MaleatDogleg_Pot_fisheries_u10(3)
           -50            20      -4.22041            -5             3             1          4          0          0          0          0          0          0          0  #  SzSel_MaleatMaxage_Pot_fisheries_u10(3)
# 4   Pot_fisheries_10to12 LenSelex
# 5   Pot_fisheries_o12 LenSelex
# 6   Bycatch_fisheries_historical LenSelex
             5            23            13            13            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P1_Bycatch_fisheries_historical(6)
           -10            10             1             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P2_Bycatch_fisheries_historical(6)
           -10            10             0             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P3_Bycatch_fisheries_historical(6)
           -10            10             0             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P4_Bycatch_fisheries_historical(6)
           -10            10          -999             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P5_Bycatch_fisheries_historical(6)
           -10            10             1             0            99             0        -99          0          0          0          0          0          0          0  #  SizeSel_P6_Bycatch_fisheries_historical(6)
# 7   Bycatch_fisheries_gillnet LenSelex
# 8   Bycatch_fisheries_trawl LenSelex
# 1   Observer_inshore_u10 AgeSelex
# 2   Pot_fisheries_historical AgeSelex
# 3   Pot_fisheries_u10 AgeSelex
# 4   Pot_fisheries_10to12 AgeSelex
# 5   Pot_fisheries_o12 AgeSelex
# 6   Bycatch_fisheries_historical AgeSelex
# 7   Bycatch_fisheries_gillnet AgeSelex
# 8   Bycatch_fisheries_trawl AgeSelex
#_No_Dirichlet parameters
# timevary selex parameters 
#_          LO            HI          INIT         PRIOR         PR_SD       PR_type    PHASE  #  parm_name
          12.5            20         16.25            13             3             1      2  # Retain_L_infl_Observer_inshore_u10(1)_BLK2repl_1986
            13            20       14.0808            14             3             1      2  # Retain_L_infl_Observer_inshore_u10(1)_BLK2repl_1994
          0.01            50        25.005             5             1             1      2  # Retain_L_width_Observer_inshore_u10(1)_BLK2repl_1986
             0             2      0.186343             1             1             1      2  # Retain_L_width_Observer_inshore_u10(1)_BLK2repl_1994
           -30           100            35            10             1             1      3  # Retain_L_asymptote_logit_Observer_inshore_u10(1)_BLK2repl_1986
           -30            50       1.07814            -1             1             1      3  # Retain_L_asymptote_logit_Observer_inshore_u10(1)_BLK2repl_1994
           -50            50   9.14613e-06             1             1             1      3  # Retain_L_maleoffset_Observer_inshore_u10(1)_BLK2repl_1986
           -50            50     -0.270273             1             1             1      3  # Retain_L_maleoffset_Observer_inshore_u10(1)_BLK2repl_1994
          12.5            20        16.251            13             3             1      2  # Retain_L_infl_Pot_fisheries_historical(2)_BLK2repl_1986
            13            50       16.1686            14             3             1      2  # Retain_L_infl_Pot_fisheries_historical(2)_BLK2repl_1994
             0            90       46.1571            20             1             1      2  # Retain_L_width_Pot_fisheries_historical(2)_BLK2repl_1986
             0             5        1.4272             2             1             1      2  # Retain_L_width_Pot_fisheries_historical(2)_BLK2repl_1994
           -50            90            20            10             1             1      3  # Retain_L_asymptote_logit_Pot_fisheries_historical(2)_BLK2repl_1986
           -50            90            20            10             1             1      3  # Retain_L_asymptote_logit_Pot_fisheries_historical(2)_BLK2repl_1994
          -120            90       6.28852             1             1             1      3  # Retain_L_maleoffset_Pot_fisheries_historical(2)_BLK2repl_1986
           -50            90      0.533915             1             1             1      3  # Retain_L_maleoffset_Pot_fisheries_historical(2)_BLK2repl_1994
          12.5            20         16.25            13             3             1      2  # Retain_L_infl_Pot_fisheries_u10(3)_BLK2repl_1986
            13            30       18.3084            14             3             1      2  # Retain_L_infl_Pot_fisheries_u10(3)_BLK2repl_1994
             0           100            50             5             1             1      2  # Retain_L_width_Pot_fisheries_u10(3)_BLK2repl_1986
             0             3       2.14084           0.5             1             1      2  # Retain_L_width_Pot_fisheries_u10(3)_BLK2repl_1994
           -50            50  -2.80721e-06            10             1             1      3  # Retain_L_asymptote_logit_Pot_fisheries_u10(3)_BLK2repl_1986
           -50            50       4.62571           0.3             1             1      3  # Retain_L_asymptote_logit_Pot_fisheries_u10(3)_BLK2repl_1994
           -10            10  -1.08359e-06             1             1             1      3  # Retain_L_maleoffset_Pot_fisheries_u10(3)_BLK2repl_1986
           -50            50      -5.69362             1             1             1      3  # Retain_L_maleoffset_Pot_fisheries_u10(3)_BLK2repl_1994
# info on dev vectors created for selex parms are reported with other devs after tag parameter section 
#
0   #  use 2D_AR1 selectivity? (0/1)
#_no 2D_AR1 selex offset used
#_specs:  fleet, ymin, ymax, amin, amax, sigma_amax, use_rho, len1/age2, devphase, before_range, after_range
#_sigma_amax>amin means create sigma parm for each bin from min to sigma_amax; sigma_amax<0 means just one sigma parm is read and used for all bins
#_needed parameters follow each fleet's specifications
# -9999  0 0 0 0 0 0 0 0 0 0 # terminator
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read and autogen if tag data exist; 1=read
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase  dev_vector
#      1    22     1     0     0     0     0     1     1  1983  2005     1 -0.131509 -0.0193672 0.0147303 0.0252496 0.134666 0.0762359 -0.219826 0.286099 0.0568827 0.0852705 0.0642916 0.0199507 -0.0242764 -0.018817 -0.263218 0.0549408 0.252833 0.539127 0.345751 0.48392 0.497007 0.468146 0.159362
#      1    23     3     0     0     0     0     2     1  1983  2005     1 -0.0195158 -0.0232421 -0.0147889 -0.0157911 -0.0310621 0.00304592 0.00312621 0.0131395 0.00142303 0.00676673 0.00902154 0.004476 0.00796475 0.0142008 0.0205472 0.0311961 0.0264947 0.0214355 0.0242144 0.0188041 -0.00686782 -0.0194903 -0.0693634
#      5     7     5     2     2     0     0     0     0     0     0     0
#      5     8     7     2     2     0     0     0     0     0     0     0
#      5     9     9     2     2     0     0     0     0     0     0     0
#      5    10    11     2     2     0     0     0     0     0     0     0
#      5    25    13     2     2     0     0     0     0     0     0     0
#      5    26    15     2     2     0     0     0     0     0     0     0
#      5    27    17     2     2     0     0     0     0     0     0     0
#      5    28    19     2     2     0     0     0     0     0     0     0
#      5    43    21     2     2     0     0     0     0     0     0     0
#      5    44    23     2     2     0     0     0     0     0     0     0
#      5    45    25     2     2     0     0     0     0     0     0     0
#      5    46    27     2     2     0     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      1      1         0
      4      1   1.93028
      1      2         0
      4      2   14.1773
      1      3         0
      4      3    1.9527
      1      4         0
      1      5         0
      1      7         0
      1      8         0
 -9999   1    0  # terminator
#
4 #_maxlambdaphase
1 #_sd_offset; must be 1 if any growthCV, sigmaR, or survey extraSD is an estimated parameter
# read 8 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag-comp; 16=Tag-negbin; 17=F_ballpark; 18=initEQregime
#like_comp fleet  phase  value  sizefreq_method
 1 1 2 1 1
 4 1 2 1 1
 8 2 2 1 1
 4 2 2 1 1
 8 3 2 1 1
 8 4 2 1 1
 8 7 2 1 1
 8 8 2 1 1
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  0 0 0 0 #_CPUE/survey:_1
#  0 0 0 0 #_CPUE/survey:_2
#  1 1 1 1 #_CPUE/survey:_3
#  1 1 1 1 #_CPUE/survey:_4
#  1 1 1 1 #_CPUE/survey:_5
#  0 0 0 0 #_CPUE/survey:_6
#  1 1 1 1 #_CPUE/survey:_7
#  1 1 1 1 #_CPUE/survey:_8
#  1 1 1 1 #_discard:_1
#  1 1 1 1 #_discard:_2
#  1 1 1 1 #_discard:_3
#  0 0 0 0 #_discard:_4
#  0 0 0 0 #_discard:_5
#  0 0 0 0 #_discard:_6
#  0 0 0 0 #_discard:_7
#  0 0 0 0 #_discard:_8
#  1 1 1 1 #_lencomp:_1
#  1 1 1 1 #_lencomp:_2
#  1 1 1 1 #_lencomp:_3
#  0 0 0 0 #_lencomp:_4
#  0 0 0 0 #_lencomp:_5
#  0 0 0 0 #_lencomp:_6
#  0 0 0 0 #_lencomp:_7
#  0 0 0 0 #_lencomp:_8
#  1 1 1 1 #_init_equ_catch1
#  1 1 1 1 #_init_equ_catch2
#  1 1 1 1 #_init_equ_catch3
#  1 1 1 1 #_init_equ_catch4
#  1 1 1 1 #_init_equ_catch5
#  1 1 1 1 #_init_equ_catch6
#  1 1 1 1 #_init_equ_catch7
#  1 1 1 1 #_init_equ_catch8
#  1 1 1 1 #_recruitments
#  1 1 1 1 #_parameter-priors
#  1 1 1 1 #_parameter-dev-vectors
#  1 1 1 1 #_crashPenLambda
#  0 0 0 0 # F_ballpark_lambda
0 # (0/1/2) read specs for more stddev reporting: 0 = skip, 1 = read specs for reporting stdev for selectivity, size, and numbers, 2 = add options for M,Dyn. Bzero, SmryBio
 # 0 2 0 0 # Selectivity: (1) fleet, (2) 1=len/2=age/3=both, (3) year, (4) N selex bins
 # 0 0 # Growth: (1) growth pattern, (2) growth ages
 # 0 0 0 # Numbers-at-age: (1) area(-1 for all), (2) year, (3) N ages
 # -1 # list of bin #'s for selex std (-1 in first bin to self-generate)
 # -1 # list of ages for growth std (-1 in first bin to self-generate)
 # -1 # list of ages for NatAge std (-1 in first bin to self-generate)
999

