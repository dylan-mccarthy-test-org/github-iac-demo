locals {
    repo_teams_path = "repo-teams"
    repo_teams_files = {
        for file in fileset(local.repo_teams_path, "*.csv"):
        trimsuffix(file, ".csv") => csvdecode(file("${local.repo_teams_path}/${file}"))
    }

    team_csv_data = csvdecode(file("teams.csv"))
}