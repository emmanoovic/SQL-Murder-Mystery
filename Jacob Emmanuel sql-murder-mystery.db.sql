--You vaguely remember that the crime was a murder that occurred sometime on Jan.15, 2018 in SQL CITY


SELECT *
FROM crime_scene_report 
WHERE date = 20180115
AND type = 'murder'
and city = 'SQL City'

--2 witnesses 
-- first one lives at the last house on Northwestern Dr
-- second one lives on Franklin Ave.... Annabel


--First Witness id-14887
select *
from person
where address_street_name = 'Northwestern Dr' 
order by address_number desc 
limit 1


--Second Witness id-16371
select *
from person
where address_street_name = 'Franklin Ave'
and name like 'Annabel%'

--checking for the witness interviews using their id
select *
from interview
where person_id IN (14887, 16371)


--interview 1; "get fit now bag", "48Z", "gold member", plate included "H42W", "individual was a man"
-- interview 2; january 9

SELECT *
from get_fit_now_member gfnm
join get_fit_now_check_in gfnc
on gfnm.id = gfnc.membership_id
where membership_status = 'gold'
and id like '%48z%'
and check_in_date is 20180109

--Got names for 2 suspects from the gym members who have gold membership and also checked in on jan 9 and also both have 48Z in their ids.... 
--Joe Germuska membership_id ; 48Z7A, person_id; 28819
--Jeremy Bowers membership_id; 48Z55, person-ID; 67318

--now we have to link the person table to the drivers_license and then trace it back to the gym membership 
select *
from person
Join drivers_license
on person.license_id = drivers_license.id
join get_fit_now_member
on person.id = get_fit_now_member.person_id
where drivers_license.plate_number like '%H42W%'

--From this we can confirm that Jeremy was the murderer as his licence_id from the person table matches with the DL id and also the person_id matches from the query we got from the 2 suspects

-- from Jeremy bowers interview
SELECT *
from interview
where person_id is 67318


-- he was hired by a woman, 5'5(65") or 5'7(67), red hair, Tesla Model S. SQL Symphony Concert 3 times in 201712

select *
from Person 
join drivers_license
on person.license_id = drivers_license.id
WHERE car_model = 'Model S'
and car_make = 'Tesla'
and gender = 'female'
and hair_color = 'red'

--3 suspects were Red Korb - 78881
--                Regina George - 90700
--                Miranda Priestly - 99716



select *
from person
join facebook_event_checkin fb
on person.id = fb.person_id
where fb.person_id in (78881, 90700, 99716)

--This confirms Miranda Priestly sent Jeremy Bowers and was behind the murder.

