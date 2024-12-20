// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManTestTeamArsenal(){

var keeper = new UltManPlayer()
keeper.name = ["David", "Raya"]
keeper.position = FootballPositions.GK
keeper.preferredPosition = FootballPositions.GK
keeper.tier = 1
ds_list_add(formationColumns[FormationColumns.Goalkeeper], keeper)
ds_list_add(keeper.playableColumns, FormationColumns.Goalkeeper)
ds_list_add(squad, keeper)

var player = new UltManPlayer()
player.name = ["Ricardo", "Calafiori"]
player.position = FootballPositions.LB
player.preferredPosition = FootballPositions.LB
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(player.playableColumns, FormationColumns.Defense)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["M.", "Gabriel"]
player.position = FootballPositions.CB
player.preferredPosition = FootballPositions.CB
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(player.playableColumns, FormationColumns.Defense)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["William", "Saliba"]
player.position = FootballPositions.CB
player.preferredPosition = FootballPositions.CB
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(player.playableColumns, FormationColumns.Defense)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Benjamin", "White"]
player.position = FootballPositions.RB
player.preferredPosition = FootballPositions.RB
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Defense], player)
ds_list_add(player.playableColumns, FormationColumns.Defense)
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Thomas", "Partey"]
player.position = FootballPositions.CDM
player.preferredPosition = FootballPositions.CDM
player.tier = 1
ds_list_add(formationColumns[FormationColumns.DefensiveMidfielder], player)
ds_list_add(player.playableColumns, FormationColumns.Defense)
ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Declan", "Rice"]
player.position = FootballPositions.CM
player.preferredPosition = FootballPositions.CM
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Midfield], player)
ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
ds_list_add(player.playableColumns, FormationColumns.Midfield)
ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Martin", "Odegaard"]
player.position = FootballPositions.CM
player.preferredPosition = FootballPositions.CM
player.topPassSpd = 4500
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Midfield], player)
ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
ds_list_add(player.playableColumns, FormationColumns.Midfield)
ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Gabriel", "Martinelli"]
player.position = FootballPositions.LW
player.preferredPosition = FootballPositions.LW
player.topSpd = 450
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Kai", "Havertz"]
player.position = FootballPositions.ST
player.preferredPosition = FootballPositions.ST
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Bukayo", "Saka"]
player.position = FootballPositions.RW
player.preferredPosition = FootballPositions.RW
player.dribbling = 4000
player.tier = 1
ds_list_add(formationColumns[FormationColumns.Attackers], player)
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
ds_list_add(squad, player)


var player = new UltManPlayer()
player.name = ["Gabriel", "Jesus"]
player.position = FootballPositions.SUB
player.preferredPosition = FootballPositions.ST
player.tier = 1
ds_list_add(player.playableColumns, FormationColumns.Attackers)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["J.", "Jorginho"]
player.position = FootballPositions.SUB
player.preferredPosition = FootballPositions.CDM
player.tier = 1
ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
ds_list_add(player.playableColumns, FormationColumns.Midfield)
ds_list_add(squad, player)

var player = new UltManPlayer()
player.name = ["Mikel", "Merino"]
player.position = FootballPositions.SUB
player.preferredPosition = FootballPositions.CM
player.tier = 1
ds_list_add(player.playableColumns, FormationColumns.OffensiveMidfield)
ds_list_add(player.playableColumns, FormationColumns.DefensiveMidfielder)
ds_list_add(player.playableColumns, FormationColumns.Midfield)
ds_list_add(squad, player)

}