SELECT *
FROM (WITH CN_applicant_IDs AS (SELECT p."id", p."first_Name", p."last_Name", date_part('year',age(p."birthDate")) age, p."email", p."CityId", p."resume", p."createdAt"
FROM "public"."Users" p
WHERE (p."CountryCode" = 'VN') AND (p."createdAt" between '20191113' and '20191118')
ORDER BY p."createdAt")

SELECT DENSE_RANK() OVER (ORDER BY v."id") AS ID_Number,  v."first_Name", v."last_Name", v."age", v."email", c."name" city_name, v."createdAt" User_SignUp_Date,
a."JobId", a."createdAt" JobApplicationDate,
CASE WHEN DATE_PART('day', a."createdAt"::timestamp - v."createdAt"::timestamp) > 3 THEN 'No'
ELSE 'Yes' END AS within_3_days,
CASE WHEN v."resume" isnull THEN 'False'
    ELSE 'True' END AS Resume_attached,
v."resume",
v."id" user_ID
FROM "public"."Applications" a
JOIN VN_applicant_IDs v
ON v.id = a."ApplicantId"
LEFT JOIN "public"."Cities" c
ON v."CityId" = c."id") t2
WHERE t2.within_3_days = 'Yes'
