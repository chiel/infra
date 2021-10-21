# Infra

This repository contains my personal infra stack, managed with Terraform.

I like using Kubernetes whenever I'm deploying side-projects, but I don't exactly need a separate cluster for every single project, so I use a multi-tenant setup.

This repository contains all the shared resources that I use between projects such as the Kubernetes cluster with an nginx ingress, certificate management and a monitoring stack.

Most of the time, I include the resources required for a given project in those repositories and simply include them here as modules, passing input variables and providers as needed.

I currently don't have any automation set up around actually running this in GitHub Actions (besides some formatting and validating) since it's just me working on this, so I just execute it on my local machine.

That said, I do store my state centrally in a DigitalOcean Space (S3-compatible offering from DO).
