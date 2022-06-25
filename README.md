# Nix Auto Changelog

This flake provides run [auto-changelog][auto-changelog homepage], a NodeJS tool
for generating a changelog from git tags and commit history.

The idea behind this tool is to have an up-and-running tool to generate a
changelog using [Nix][nix homepage].

## Usage

In your project directory, run:

```shell
nix run github:loophp/nix-auto-changelog
```

To generate the changelog for until a specific tag (`<tag>`):

```shell
nix run github:loophp/nix-auto-changelog -- -v <tag>
```

To see all the available options, run:

```shell
nix run github:loophp/nix-auto-changelog -- --help
```

A configuration file `.auto-changelog` can be created per project, as such:

```json
{
  "output": "CHANGELOG.md",
  "template": "keepachangelog",
  "unreleased": true,
  "commitLimit": false,
  "hideCredit": true,
  "sortCommits": "date-desc",
  "breakingPattern": "BREAKING CHANGE: yes"
}
```

For all the configuration properties, check the [project homepage][auto-changelog homepage].

## Contributing

Feel free to contribute by sending pull requests. We are a
usually very responsive team and we will help you going
through your pull request from the beginning to the end.

For some reasons, if you can't contribute to the code and
willing to help, sponsoring is a good, sound and safe way
to show us some gratitude for the hours we invested in this
package.

[![Sponsor!][sponsor github]][sponsor github link]

Sponsor me on [Github][sponsor github link] and/or any of [the contributors][github contributors].

## Changelog

See [CHANGELOG.md][changelog file] for a changelog based on [git commits][github commit history].

For more detailed changelogs, please check [the release changelogs][github release changelogs].

[sponsor github]: https://img.shields.io/badge/Sponsor-Github-brightgreen.svg?style=flat-square
[sponsor github link]: https://github.com/sponsors/drupol
[nix homepage]: https://nixos.org/
[auto-changelog homepage]: https://github.com/CookPete/auto-changelog
[changelog file]: https://github.com/loophp/nix-auto-changelog/blob/main/CHANGELOG.md
[github commit history]: https://github.com/loophp/nix-auto-changelog/commits/main
[github release changelogs]: https://github.com/loophp/nix-auto-changelog/releases
[github contributors]: https://github.com/loophp/nix-auto-changelog/graphs/contributors
