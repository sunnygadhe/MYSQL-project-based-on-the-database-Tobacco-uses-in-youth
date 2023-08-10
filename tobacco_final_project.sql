use  tobacco_user;
SELECT 
    *
FROM
    tobacco_use;


#Q 1 Which state/region has the highest percentage of ever tobacco users?
SELECT 
    state,max(ETU) as highest_tobacco_user
FROM
    tobacco_use
GROUP BY state
ORDER BY highest_tobacco_user  DESC limit 5;
--the top 5 states/UTs with the highest average percentage of ever tobacco users are as follows:
--Mizoram: 91.1%
--Arunachal Pradesh: 75.7%
--Nagaland: 71.5%
--Meghalaya: 61.7%
--Sikkim: 43.6%

# Q2  What is the region/area wise average age of initiation for cigarettes, bidis, and smokeless tobacco across different areas?
select 
AREA,
AVG(maic)AS median_age_of_initiation_for_cigarettes,
AVG(maib)AS median_age_of_initiation_for_bidi,
AVG(maist) AS median_age_of_initiation_for_smokeless_tobacco
FROM
    tobacco_use
GROUP BY area
order by median_age_of_initiation_for_cigarettes desc ;


#Q3 Is there a correlation between awareness about e-cigarettes and ever e-cigarette use?
select State,( avg( 'aaec' * 'eecu') - (avg( 'aaec' ) + avg( 'eecu' ) )) / ( stddev( 'aaec' ) * stddev('eecu') ) as 'correlation'
from tobacco_use group by state;
    
# Q4 What is the state wise average age of of initiation for cigarettes, bidis, and smokeless tobacco across different areas?
 select 
state,
ROUND(AVG(maic)) AS median_age_of_initiation_for_cigarettes,
ROUND(AVG(maib)) AS median_age_of_initiation_for_bidi,
ROUND(AVG(maist)) AS median_age_of_initiation_for_smokeless_tobacco
FROM
    tobacco_use
GROUP BY state
order by median_age_of_initiation_for_cigarettes desc ; 
  



#Q6 Are there any differences in tobacco usage rates between urban and rural areas?
SELECT 
    AREA, ROUND(AVG(CTU)) AS AVEREGE_TOBACCO_USER
FROM
    tobacco_use
WHERE
    AREA = 'URBAN'
UNION ALL 
SELECT 
    AREA,ROUND(AVG(CTU)) AS AVERAGE_TOBACCO_USER 
FROM 
    tobacco_use
WHERE
    AREA = 'RURAL'
;
--there is a difference in tobacco usage rates between urban and rural areas. 
--The average usage rate for current tobacco users in urban areas is approximately 10.14%, 
--while in rural areas, it is approximately 12.25%. 
--This suggests that tobacco usage rates are slightly higher in rural areas compared to urban areas. 

#Q7 What percentage of current tobacco smokers have attempted to quit in the past 12 months in RURAL area ?
SELECT 
    STATE, CTSWQ
FROM
    TOBACCO_USE
WHERE
    area = 'rural';
#Q8 What percentage of current tobacco smokers have attempted to quit in the past 12 months in urban area?
SELECT 
    STATE, CTSWQ
FROM
    TOBACCO_USE
WHERE
    area = 'urban';
    
# Q9 How does exposure to tobacco smoke vary between different public places (home, enclosed spaces, outdoor areas)?
SELECT 
    area,
    ROUND(AVG(etshp)) AS averege_Exposure_to_tobacco_smoke_at_home_public_place,
    ROUND(AVG(ETSIEPP)) AS averege_Exposure_to_tobacco_smoke_at_enclosed_public_place,
    ROUND(AVG(ETSIEPP)) AS averege_Exposure_to_tobacco_smoke_at_enclosed_public_place,
    ROUND(AVG(ETSOPP)) AS averege_Exposure_to_tobacco_smoke_at_outdoor_public_place
FROM
    tobacco_use
GROUP BY area;

# Q10 what is variation in  Current tobacco smokers who tried to quit smoking in the past 12 months (%)
SELECT 
   area,ROUND(AVG(CTSWQ)) as averege_customer_wanted_to_quit_tobacco 
FROM
    TOBACCO_USE
WHERE
    area = 'urban'
group by area
    UNION ALL
SELECT 
 area,ROUND(AVG(CTSWQ)) as averege_customer_wanted_to_quit_tobacco 
FROM
    TOBACCO_USE
WHERE
    area = 'RURAL'
    group by area  ;
    
#Q11 What is the major source of tobacco products for cigarette, bidi, and smokeless tobacco users?
SELECT 
    area,
    ROUND(AVG(mstp)) AS averege_Major_source_of_tobacco_product_Cigarette_Store,
    ROUND(AVG(MSTBP)) AS averege_Major_source_of_tobacco_product_bidi_pan_shop,
    ROUND(AVG(MSTPTS)) AS averege_Major_source_of_tobacco_product_bidi_Store,
    ROUND(AVG(MSTPTP)) AS averege_Major_source_of_smokless_tobacco_product_Cigarette_Store
FROM
    tobacco_use
GROUP BY area;

# Q.12 What percentage of ever tobacco smokers have also used paan masala together with tobacco?
SELECT 
    (SUM(EUOPMTWT) / SUM(ets)) * 100
FROM
    tobacco_use;

# Q.13 How many schools have followed tobacco-free school guidelines?
SELECT 
    COUNT(SFTFSG)
FROM
    tobacco_use;
    
# Q.14 How many schools are authorized by the state government to collect fines for violations under Section-6 of COTPA, 2003?
 SELECT 
    COUNT(SASCFVS6)
FROM
    tobacco_use;
    
# Q.15 How many students have seen tobacco advertisements anywhere in the past 30 days?
SELECT 
   COUNT(SWSTAA30D)
FROM
    tobacco_use;

#Q.16 What percentage of schools are aware of the policy for displaying a tobacco-free school board?
SELECT 
(sum(SAPDTFSB) / sum(SHACOTPA )) * 100
FROM
    tobacco_use;
    
# Q.17 What is the percentage of students who have witnessed tobacco use in movies or TV shows in the past 30 days?
SELECT 
    (SUM(SWAUTMM30D) / SUM(SWSTAA30D)) * 100
FROM
    tobacco_use;

# finding insights that student saw  or not in social activty like gathering or mass medias to promote tobaco use or not vs
# student see anti tobacco ads or messages in social media , 
 #all about the fever of students 
# Q.17 which messages or ads  student saw mostly anti tobacco or tobacco promoting 
 select  state,
round(avg(SWNAMAP30D),2) as no_of_student_saw_anti_tobacco_messages,
round(avg(SWMATMMM30D),2) as no_of_Students_noticed_anti_tobacco_messages_in_mass_media,
round(avg(SWNAMSF30D),2) as Students_who_noticed_anti_tobacco_messages_sporting_fairs_concerts_community_events_or_social_gatherings,
round(avg(SWSTAA30D),2) as Students_who_saw_tobacco_advertisements_anywhere_in_past_30_days,
round(avg(SWAUTMM30D),2) as Students_who_saw_anyone_using_tobacco_on_mass_media_in_past_30_days ,
round(avg(sWNCAPS30D),2) as  Students_who_noticed_cigarette_advertisements_promotions_at_point_of_sale_in_past_30_days
from tobacco_use 
group by state ;


# as we see from above analysis we saw that average percentage of student who  observed anti tobacco ads or messages is not much greater 
#than the tobacco promotions and ads tobacco promoting ads 
#and messages are less in sport and game events as average percentage of Arunachal pradesh is at the top  in promoting Anti Tobacco message and
# and it is also higher in promoting  tobacco ads as a result in our country anti tobacco messages and tobaccco promoting messages are aprroximately equl
# that is in our country tobacco ads are presenting and also giving  anti tobacco messages to peoples . 


# Q.18 How does exposure to tobacco smoke in outdoor public places compare to exposure in enclosed public places?
SELECT (stddev(ETSIEPP))^2 AS Exposure_to_tobacco_smoke_inside_any_enclosed_public_places,
(stddev(ETSOPP))^2 AS  Exposure_to_tobacco_smoke_at_any_outdoor_public_places 
FROM tobacco_use
;
# as Exposure to tobacco smoke inside any enclosed public  places and Exposure to tobacco smoke at any outdoor public places has no variation
# among the data of this two columns there is no exposure of smoke in public place vs smoke in enclosed public place 

#Q.19 How many students have noticed health warnings on tobacco product packages in the past 30 days?
SELECT 
    COUNT(SWNHWATPP30D) AS Students_who_noticed_health_warnings_on_any_tobacco_product_cigarette_packages_in_past_30_days
FROM
    tobacco_use; 
    

#Q.20 How many student thought it is difficult to quit once someone starts smoking tobacco and how many thought other people that tobacco smoking is harmful to them
SELECT 
    COUNT(STDQOSSST) AS Students_who_thought_it_is_difficult_to_quit_once_someone_starts_smoking_tobacco ,
    COUNT(STOPTSHT) AS Students_who_thought_other_peoples_tobacco_smoking_is_harmful_to_them
FROM
    tobacco_use;
    
/*student that thought  it is difficult to quit once someone starts smoking tobacco*/
-- all that student thought other people that tobacco smoking is harmful to them

# Q.21 what is the average percentage of no of School heads aware of COTPA, 2003 and wich state have maximum  ?
SELECT 
    state, ROUND(AVG(SHACOTPA),2) as average_no_of_school_heads_aware_of_COTPA
FROM
    tobacco_use
GROUP BY state
order by ROUND(AVG(SHACOTPA), 2) DESC;

/* FROM RESULTS WE SAY THAT Rajasthan,Punjab,Bihar,Chandigarh,Dadar and Nagar Haweli,Delhi,Goa,Sikkim have average 100% percent of School heads aware of COTPA
and Meghalay,Karnataka,Nagaland,Madhya pradesh,Lakshadweep,Daman and Diu ,Haryana,Gujarat,tripura,Uttarpradesh,Jharkhand ,Kerala,Westbengal 
have average percentage grater than 90% */

# Q.22 what is the maximum no of BIDI user in maharastra? 
select state,sum(CBU) 
from tobacco_use
where state = 'Maharashtra'
 group by state; 
 
# Q.23 which producy  among bidi ,cigarate,smokeless tobacco is widely used in maharastra in percentage ;

SELECT 
    state,sum(cbu), SUM(ccu),sum(CSTU)
FROM
    tobacco_use
WHERE
    state = 'Maharashtra'
GROUP BY state;


