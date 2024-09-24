// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManTestTeamArsenal(){

/*
ds_list_add(formationColumns[FormationColumns.Attackers], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.Attackers], new UltManPlayer())

ds_list_add(formationColumns[FormationColumns.DefensiveMidfielder], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.DefensiveMidfielder], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.DefensiveMidfielder], new UltManPlayer())

ds_list_add(formationColumns[FormationColumns.Defense], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.Defense], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.Defense], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.Defense], new UltManPlayer())
ds_list_add(formationColumns[FormationColumns.Defense], new UltManPlayer())*/

var keeper = new UltManPlayer()
keeper.name = ["David", "Raya"]
keeper.position = FootballPositions.GK
ds_list_add(formationColumns[FormationColumns.Goalkeeper], keeper)
ds_list_add(squad, keeper)

var player = new UltManPlayer()
player.name = ["Ricardo", "Calafiori"]
player.position = FootballPositions.LB
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["M.", "Gabriel"]
player.position = FootballPositions.CB
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["William", "Saliba"]
player.position = FootballPositions.CB
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Benjamin", "White"]
player.position = FootballPositions.RB
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Thomas", "Partey"]
player.position = FootballPositions.CDM
ds_list_add(formationColumns[FormationColumns.DefensiveMidfielder], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Declan", "Rice"]
player.position = FootballPositions.CM
ds_list_add(formationColumns[FormationColumns.Midfield], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Martin", "Odegaard"]
player.position = FootballPositions.CM
ds_list_add(formationColumns[FormationColumns.Midfield], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Gabriel", "Martinelli"]
player.position = FootballPositions.LW
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Kai", "Havertz"]
player.position = FootballPositions.ST
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Bukayo", "Saka"]
player.position = FootballPositions.RW
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(squad, player)
}