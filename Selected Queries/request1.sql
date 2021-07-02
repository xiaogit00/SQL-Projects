WITH apps_21 AS (SELECT *
FROM "public"."Applications" a
WHERE a."createdAt" between (current_date - 21) and current_date
ORDER BY a."createdAt"),
    vn_users AS (SELECT *
FROM "public"."Users" u
WHERE u."CountryCode" = 'CN')

SELECT DENSE_RANK() OVER (ORDER BY u."id") AS user_num,
u."id" user_id, u."first_Name", u."last_Name", date_part('year',age(u."birthDate")) age, u."email", c."name" city_name, a."JobId",j."title" job_title, a."createdAt" application_date, u."createdAt" signup_date,
CASE WHEN a."createdAt" between (current_date - 7) and current_date THEN 'Within 7 Days'
WHEN a."createdAt" between (current_date - 14) and current_date THEN 'Within 14 Days'
ELSE 'Within 21 Days' END AS within_7_14_21
FROM apps_21 a
JOIN CN_users u
ON u."id" = a."ApplicantId"
JOIN "public"."Jobs" j
ON j."id" = a."JobId"
JOIN "public"."Cities" c
ON c."id" = u."CityId"
