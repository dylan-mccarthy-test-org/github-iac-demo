resource "github_team" "all" {
  for_each = {
    for team in csvdecode(file("teams.csv")):
    team.name => team
  }

  name = each.value.name
  description = each.value.description
  privacy = each.value.privacy
  create_default_maintainer = true
}