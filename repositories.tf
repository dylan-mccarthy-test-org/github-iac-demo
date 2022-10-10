resource "github_repository" "infrastructure" {
    name        = "teamonerepo"
    description = "This is a repository for team one"
    visibility  = "private"
    has_issues  = true
    has_projects = true
    has_wiki = true
    auto_init = true
    allow_merge_commit = true
    allow_rebase_merge = true
    allow_squash_merge = true
    delete_branch_on_merge = true
    vulnerability_alerts = true
    has_downloads = true
    archived = false
}

resource "github_team_repository" "infrastructure" {
  for_each = {
    for team in local.repo_teams_files["infrastructure"]:
    team.team_name => {
        team_id = github_team.all[team.team_name].id
        permission = team.permission
    } if lookup(github_team.all, team.team_name, false) != false
  }

  team_id = each.value.team_id
  repository = github_repository.infrastructure.id
  permission = each.value.permission
}