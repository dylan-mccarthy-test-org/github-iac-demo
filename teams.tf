resource "github_team" "all" {
  for_each = { for team in local.team_csv_data : team.name => team }

  name = each.value.name
  description = each.value.description
  privacy = each.value.privacy
}