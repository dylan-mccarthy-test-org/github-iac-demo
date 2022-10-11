resource "github_repository" "infrastructure" {
    name        = "teamonerepo"
    description = "This is a repository for team one"
    visibility  = "public"
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

resource "github_repository" "teamtworepo" {
    name = "teamtworepo"
    visibility = "private"
    has_issues = true
    has_projects = true
    has_wiki = false
    allow_merge_commit = true
    allow_rebase_merge = true
    allow_squash_merge = true
    vulnerability_alerts = false
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

resource "github_branch_protection_v3" "infrastructure" {
    repository = github_repository.infrastructure.name
    branch = "main"
    enforce_admins = true
    required_pull_request_reviews {
        dismiss_stale_reviews = true
        required_approving_review_count = 2
    }
}