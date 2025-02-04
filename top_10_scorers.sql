--the top 10 players by scorer in tournament history with FG pct 

With top10 AS (

				SELECT team_id,team_name,team_market, player_id, full_name, 

				Round(SAFE_DIVIDE(sum(field_goals_made),sum(field_goals_att))*100,2) AS FG_PCT,

				sum(points) as total_points,

				RANK() over (order by sum(points) DESC) AS rnk 

				FROM `bigquery-public-data.ncaa_basketball.mbb_players_games_sr` 

				Where points is not null

				Group by team_id,team_name,team_market, player_id, full_name

			)

Select full_name, mascot, total_points,concat(FG_PCT,'%') AS FG_PCT, 

rnk as Rank FROM top10 t

LEFT JOIN `bigquery-public-data.ncaa_basketball.mascots` m

ON t.team_market = m.market AND t.team_name = m.name

WHERE rnk <=10

order by rnk;