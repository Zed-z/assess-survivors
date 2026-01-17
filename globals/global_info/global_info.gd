extends Node

var player: Player
var combat_ui_overlay: UIOverley
var enemy_spawner: EnemySpawner
var assess_manager: AssessManagerClass
var projectile_holder: ProjectileHolder
var score_manager: ScoreManager
var game_camera: GameCamera
var gameplay_scene: GameplayScene

var game_time: float

enum GameType {
	Normal, Quick
}
var game_type = GameType
