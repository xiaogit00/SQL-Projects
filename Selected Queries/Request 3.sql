WITH exp AS (SELECT t2."UserId"
FROM
(SELECT e."UserId", min(e."startDate"), max(e."endDate"), (max(e."endDate") - min(e."startDate")) AS work_length
FROM "public"."Experiences" e
WHERE e."type" = 'WORK'
GROUP BY 1) t2
WHERE DATE_PART('day', t2."work_length") > 364),
    th AS (SELECT gm."CandidateId"
FROM "public"."GroupMembers" gm
WHERE (gm."GroupId" = '592fce49-8b19-4934-k01b-fbc7c3ad44ea') AND gm."status" = 'APPROVED')

SELECT u."firstName", u."lastName", u."email", u."resume", u."phone", c."name" City_name, u."id" User_Id
FROM "public"."Users" u
JOIN exp e
ON e."UserId" = u."id"
LEFT JOIN th
ON th."CandidateId" = u."id"
LEFT JOIN "public"."Cities" c
ON c."id" = u."CityId"
WHERE (th."CandidateId" isnull) AND (u."CountryCode" = 'VN')
