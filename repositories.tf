resource "github_repository" "infra" {
  name                   = "infra"
  description            = "Personal infra stack."
  homepage_url           = "https://kunkels.me"
  visibility             = "public"
  has_issues             = false
  has_projects           = false
  has_wiki               = false
  allow_merge_commit     = true
  allow_squash_merge     = false
  allow_rebase_merge     = false
  delete_branch_on_merge = true
}

resource "github_branch" "infra_main" {
  repository = github_repository.infra.name
  branch     = "main"
}

resource "github_branch_default" "default" {
  repository = github_repository.infra.name
  branch     = github_branch.infra_main.branch
}
