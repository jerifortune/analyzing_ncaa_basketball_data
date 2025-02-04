With games AS (

	Select name, points

	FROM `bigquery-public-data.ncaa_basketball.mbb_teams_games_sr` 

	UNION ALL

	Select opp_name as name, opp_points as points

	FROM `bigquery-public-data.ncaa_basketball.mbb_teams_games_sr` 

)

,PPG_det AS (

	Select name, SUM(points) as total_points, count(name) AS number_game

	FROM games

	GROUP BY name

	

)

,PPG AS (

	SElECT name, Round(total_points/number_game, 2)  AS PPG_val

	FROM PPG_det

	Order by PPG_val DESC 

)

,leading AS (

	Select name, PPG_val, LEAD(PPG_val) OVER (ORDER BY PPG_val) AS leading_val

	FROM PPG

	Order by PPG_val DESC 

)

SELECT name, PPG_val, leading_val - PPG_val AS Leading_Diff

FROM leading;