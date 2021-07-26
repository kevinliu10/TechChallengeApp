# Servian DevOps Tech Challenge - Tech Challenge App

[![Build Status][circleci-badge]][circleci]
[![Release][release-badge]][release]
[![GoReportCard][report-badge]][report]
[![License][license-badge]][license]

[circleci-badge]: https://circleci.com/gh/servian/TechChallengeApp.svg?style=shield&circle-token=8dfd03c6c2a5dc5555e2f1a84c36e33bc58ad0aa
[circleci]: https://circleci.com/gh/servian/TechChallengeApp
[release-badge]: http://img.shields.io/github/release/servian/TechChallengeApp/all.svg?style=flat
[release]:https://github.com/Servian/TechChallengeApp/releases
[report-badge]: https://goreportcard.com/badge/github.com/Servian/TechChallengeApp
[report]: https://goreportcard.com/report/github.com/Servian/TechChallengeApp
[license-badge]: https://img.shields.io/github/license/Servian/TechChallengeApp.svg?style=flat
[license]: https://github.com/Servian/TechChallengeApp/license

## Overview

This is the Servian DevOps Tech challenge. It uses a simple application to help measure a candidate's technical capability and fit with Servian. The application itself is a simple GTD Golang application that is backed by a Postgres database.

Servian provides the Tech Challenge to potential candidates, which focuses on deploying this application into a cloud environment of choice.

More details about the application can be found in the [document folder](doc/readme.md)

## Taking the challenge

For more information about taking the challenge and joining Servians's amazing team, please head over to our [recruitment page](https://www.servian.com/careers/) and apply there. Our recruitment team will reach out to you about the details of the test and be able to answer any questions you have about Servian or the test itself.

Information about the assessment is available in the [assessment.md file](ASSESSMENT.md)

## Found an issue?

If you've found an issue with the application, the documentation, or anything else, we are happy to take contributions. Please raise an issue in the [github repository](https://github.com/Servian/TechChallengeApp/issues) and read through the contribution rules found the [CONTRIBUTING.md](CONTRIBUTING.md) file for the details.

## High level overview of deployment

The deployment will create 2 types of subnets across all 3 availability zones for the ap-southeast-2 region in AWS.\
3 public subnets for the load balancer and internet access for the nat gateway and 3 private subnets to run the virtual machines and postgres database.\
The virtual machines are scaled in using an auto scale group and the [install.sh](terraform/install.sh) script runs the initial setup of the server.\
Multi-az can be switched on for the postgres database to increase availability. Currently switched off for quicker deployment.
Additional scaling policies can be applied to the auto scaling group depending on usage.

## Prerequisites to deploy

- AWS account
- AWS cli credentials are configured via shared credentials file (or any other authentication method) and terraform has access to use credentials
- Latest version of Terraform installed (tested on terraform 1.0.3)

## Deployment steps

Move to the `/terraform` dirctory of the repo\
Run `terraform init` then `terraform apply`\
Around 5 minutes after the terraform build is done, the app should be accessible via the load balancer (techchallenge-alb-XXXX.ap-southeast-2.elb.amazonaws.com)